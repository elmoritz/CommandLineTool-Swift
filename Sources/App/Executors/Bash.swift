import Foundation

protocol CommandExecuting {
    func run(commandName: String, arguments: [String], using shell: Bash.Shell?) throws -> String
}


struct Bash: CommandExecuting {
    enum BashError: Error {
        case commandNotFound(name: String)
    }
    
    enum Shell {
        case bash, sh, zsh
        
        var path: String {
            switch self {
                case .bash:
                    return "/bin/sh"
                case .sh:
                    return "/bin/sh"
                case .zsh:
                    return "/bin/zsh"
            }
        }
    }

    func run(commandName: String, arguments: [String] = [], using shell: Shell?) throws -> String {
        return try run(resolve(commandName, using: shell), with: arguments)
    }

    private func resolve(_ command: String, using shell: Shell?) throws -> String {
        let executableShell = shell ?? .zsh
        guard var bashCommand = try? run(executableShell.path , with: ["-l", "-c", "which \(command)"]) else {
            throw BashError.commandNotFound(name: command)
        }
        bashCommand = bashCommand.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return bashCommand
    }

    private func run(_ command: String, with arguments: [String] = []) throws -> String {
        let process = Process()
        process.launchPath = command
        process.arguments = arguments
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        process.launch()
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(decoding: outputData, as: UTF8.self)
        return output
    }
}

