//
//  ResetDomainCommand.swift
//  eligibility_util
//
//  Created by Kyle on 2024/7/7.
//

import ArgumentParser
import Foundation

struct ResetDomainCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "resetDomain"
    )
    
    @Argument(help: "The domain name to reset answer")
    private var domainName: String?
    
    @Flag(
        name: [
            .customLong("all"),
            .customShort("a"),
        ],
        help: "reset all domains"
    )
    private var resetAll = false
    
    private var domainType: EligibilityDomainType {
        EligibilityDomainType(name: domainName)
    }
    
    func run() throws {
        if resetAll {
            try handleResetAllDomainAnswers()
            print("Reset all domains successfully")

        } else {
            try handleResetDomainAnswer()
            print("Reset \(domainName ?? "") successfully")
        }
    }
    
    private func handleResetDomainAnswer() throws {
        let result = os_eligibility_reset_domain(domainType)
        guard result == 0 else {
            if let posixErrorCode = POSIXErrorCode(rawValue: result) {
                throw POSIXError(posixErrorCode)
            } else {
                throw NSError()
            }
        }
    }
    
    private func handleResetAllDomainAnswers() throws {
        let result = os_eligibility_reset_all_domains()
        guard result == 0 else {
            if let posixErrorCode = POSIXErrorCode(rawValue: result) {
                throw POSIXError(posixErrorCode)
            } else {
                throw NSError(domain: POSIXError.errorDomain, code: -1)
            }
        }
    }
    
    func validate() throws {
        if resetAll {
            guard domainName == nil else {
                print("Passing both --all and domain name is not supported")
                throw POSIXError(.EINVAL)
            }
            return
        }
        let domainType = domainType
        guard domainType != .invalid && domainType.rawValue <= EligibilityDomainTypeCount else {
            print("Invalid domain name")
            throw POSIXError(.EINVAL)
        }
    }
}
