//
//  SetInputCommand.swift
//  eligibility_util
//
//  Created by Kyle on 2024/7/7.
//

import ArgumentParser
import Foundation

extension [String]: @retroactive ExpressibleByArgument {
    public init?(argument: String) {
        self = argument.split(separator: ",").map(String.init)
    }
}

struct ExclusiveOptionsGroup: ParsableArguments {
    @Option(name: .long, help: "bool value")
    private var bool: Bool?

    @Option(name: .long, help: "string value")
    private var string: String?

    @Option(name: .long, help: "array value")
    private var array: [String]?

    func validate() throws {
        let array: [Any?] = [bool, string, array]
        let options = array.compactMap { $0 }
        if options.count > 1 {
            throw ValidationError("Only one of --bool, --string or --array can be provided.")
        }
    }
    
    var xpcValue: xpc_object_t? {
        if let bool {
            xpc_bool_create(bool)
        } else if let string {
            xpc_string_create(string)
        } else if let array {
            _CFXPCCreateXPCObjectFromCFObject(array as NSArray as CFArray)
        } else {
            nil
        }
    }
}

struct SetInputCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "setInput"
    )
    
    @Option(help: "The input type to set")
    private var input: EligibilityInputType
    
    @Option(help: "The status to set")
    private var status: EligibilityInputStatus
    
    @OptionGroup
    private var value: ExclusiveOptionsGroup
    
    func run() throws {
        let result = os_eligibility_set_input(input, value.xpcValue, status)
        if result == 0 {
            print("Set input command successfully")
        } else {
            print("Set input command failed: errorNum \(result)")
        }
    }
}
