//
//  Eligibility+ArgumentParser.swift
//  eligibility
//
//  Created by Kyle on 2024/7/14.
//

import ArgumentParser

extension EligibilityDomainType: ExpressibleByArgument {
    public init?(argument: String) {
        guard let rawValue = UInt64(argument) else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}

extension EligibilityDomainTypes: ExpressibleByArgument {
    public init?(argument: String) {
        guard let rawValue = UInt64(argument) else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}

extension EligibilityAnswer: ExpressibleByArgument {
    public init?(argument: String) {
        guard let rawValue = UInt64(argument) else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}

extension EligibilityInputType: ExpressibleByArgument {
    public init?(argument: String) {
        guard let rawValue = UInt64(argument) else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}

extension EligibilityInputStatus: ExpressibleByArgument {
    public init?(argument: String) {
        guard let rawValue = UInt64(argument) else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}
