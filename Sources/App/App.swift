import Foundation

public final class App {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        let bash: CommandExecuting = Bash()
        let lsOutput = try bash.run(commandName: "pwd", arguments: [], using: .zsh)
        print(lsOutput)
        let lsWithArgumentsOutput = try bash.run(commandName: "ls", arguments: ["-la"], using: .zsh)
        print(lsWithArgumentsOutput)

    }
}
