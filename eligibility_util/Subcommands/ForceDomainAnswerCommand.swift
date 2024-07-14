//
//  ForceDomainAnswerCommand.swift
//  eligibility
//
//  Created by Kyle on 2024/7/14.
//

import ArgumentParser
import Foundation

struct ForceDomainAnswerCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "forceDomainAnswer"
    )
    
    @Option(help: "The domain to force the answer for")
    var domain: EligibilityDomainType
    
    @Option(help: "The answer to force")
    var answer: EligibilityAnswer
    
    func run() throws {
        let result = os_eligibility_force_domain_answer(domain, answer, nil)
        if result == 0 {
            print("Force domain answer successfully")
        } else {
            print("Force domain answer failed: errorNum \(result)")
        }
    }
}
