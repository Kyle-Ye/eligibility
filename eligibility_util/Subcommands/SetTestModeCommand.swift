//
//  SetTestModeCommand.swift
//  eligibility
//
//  Created by Kyle on 2024/7/8.
//

import ArgumentParser
import Foundation

struct SetTestModeCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "setTestMode"
    )
    
    @Option(name: .shortAndLong, help: "Enable value for test mode")
    private var enable: Bool = false

    func run() throws {
        let result = os_eligibility_set_test_mode(enable)
        guard result == 0 else {
            if let posixErrorCode = POSIXErrorCode(rawValue: result) {
                throw POSIXError(posixErrorCode)
            } else {
                throw NSError()
            }
        }
        print("Set testMode to \(enable) successfully")
    }
}
