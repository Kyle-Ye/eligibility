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
    
    @OptionGroup(title: "The domain to reset answer")
    private var domain: DomainArguments
    
    @Flag(
        name: [
            .customLong("all"),
            .customShort("a"),
        ],
        help: "reset all domains"
    )
    private var resetAll = false
    
    func run() throws {
        if resetAll {
            try handleResetAllDomainAnswers()
            print("Reset all domains successfully")

        } else {
            try handleResetDomainAnswer()
            print("Reset \(domain) successfully")
        }
    }
    
    private func handleResetDomainAnswer() throws {
        let result = os_eligibility_reset_domain(domain.type)
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
            guard !domain.hasSet else {
                throw ValidationError("Passing both --all and --domain or --domainName is not supported")
            }
            return
        } else {
            guard domain.hasSet && domain.type != .invalid else {
                throw ValidationError("Invalid domain input")
            }
        }
    }
}
