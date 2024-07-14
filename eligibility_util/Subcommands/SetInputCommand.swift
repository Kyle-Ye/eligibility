//
//  SetInputCommand.swift
//  eligibility_util
//
//  Created by Kyle on 2024/7/7.
//

import ArgumentParser
import Foundation

struct SetInputCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "setInput"
    )
    
    @Option(help: "The input type to set")
    var input: EligibilityInputType
    
    @Option(help: "The status to set")
    var status: EligibilityInputStatus
    
    func run() throws {
        // FIXME
        let value = xpc_dictionary_create_empty()
        let result = os_eligibility_set_input(input, value, status)
        if result == 0 {
            print("Set input command successfully")
        } else {
            print("Set input command failed: errorNum \(result)")
        }
    }
}
