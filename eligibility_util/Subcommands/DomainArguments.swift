//
//  DomainArguments.swift
//  eligibility_util
//
//  Created by Kyle on 2024/7/14.
//

import ArgumentParser
import Foundation

struct DomainArguments: ParsableArguments, CustomStringConvertible {
    @Option(name: .long, help: "bool value")
    private var domainName: String?

    @Option(name: .long, help: "string value")
    private var domain: EligibilityDomainType?

    func validate() throws {
        if domain != nil && domainName != nil {
            throw ValidationError("Only one of --domain or --domainName can be provided.")
        }
        if let domainName, EligibilityDomainType(name: domainName) != .invalid {
            return
        } else if let domain, domain != .invalid {
            return
        } else {
            throw ValidationError("Invalid domain input")
        }
    }
    
    var type: EligibilityDomainType {
        if let domainName {
            EligibilityDomainType(name: domainName)
        } else if let domain {
            domain
        } else {
            .invalid
        }
    }
    
    var description: String {
        if let domainName {
            "\(domainName)-\(EligibilityDomainType(name: domainName))"
        } else if let domain {
            "\(domain)"
        } else {
            ""
        }
    }
    
    var hasSet: Bool { domainName != nil || domain != nil }
}
