//
//  GetStateDumpCommand.swift
//  eligibility
//
//  Created by Kyle on 2024/7/14.
//

import ArgumentParser
import Foundation

struct GetStateDumpCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "getStateDump"
    )
    
    func run() throws {
        var stateDump: xpc_object_t?
        let result = os_eligibility_get_state_dump(&stateDump)
        guard let stateDump,
              result == 0 else {
            if let posixErrorCode = POSIXErrorCode(rawValue: result) {
                throw POSIXError(posixErrorCode)
            } else {
                throw NSError(domain: POSIXError.errorDomain, code: -1)
            }
        }
        let type = xpc_get_type(stateDump)
        guard type == XPC_TYPE_DICTIONARY else {
            print("xpc message type must be a dictionary")
            throw NSError(domain: POSIXError.errorDomain, code: -1)
        }
        guard let cfObject = _CFXPCCreateCFObjectFromXPCObject(stateDump),
              let stateDumpDictionary = cfObject.takeUnretainedValue() as? NSDictionary else {
            print("Failed to convert the answers reply into CF objects")
            throw NSError(domain: POSIXError.errorDomain, code: -1)
        }
        print(stateDumpDictionary)
    }
}
