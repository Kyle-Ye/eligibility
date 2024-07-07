//
//  GetInternalStateCommand.swift
//  eligibility_util
//
//  Created by Kyle on 2024/7/8.
//

import ArgumentParser
import Foundation

struct GetInternalStateCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "getInternalState"
    )
    
    func run() throws {
        var internalState: xpc_object_t?
        let result = os_eligibility_get_internal_state(&internalState)
        guard let internalState,
              result == 0 else {
            if let posixErrorCode = POSIXErrorCode(rawValue: result) {
                throw POSIXError(posixErrorCode)
            } else {
                throw NSError(domain: POSIXError.errorDomain, code: -1)
            }
        }
        let type = xpc_get_type(internalState)
        guard type == XPC_TYPE_DICTIONARY else {
            print("xpc message type must be a dictionary")
            throw NSError(domain: POSIXError.errorDomain, code: -1)
        }
        guard let cfObject = _CFXPCCreateCFObjectFromXPCObject(internalState),
              let internalStateDictionary = cfObject.takeUnretainedValue() as? NSDictionary else {
            print("Failed to convert the answers reply into CF objects")
            throw NSError(domain: POSIXError.errorDomain, code: -1)
        }
        print(internalStateDictionary)
    }
}
