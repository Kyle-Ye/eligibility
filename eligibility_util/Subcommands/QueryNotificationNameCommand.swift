//
//  QueryNotificationNameCommand.swift
//  eligibility_util
//
//  Created by Kyle on 2024/7/8.
//

import ArgumentParser
import Foundation

struct QueryNotificationNameCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "queryNotificationName"
    )
    
    @Argument(help: "The domain name to query notification name")
    private var domainName: String?

    func run() throws {
        let domainType = EligibilityDomainType(name: domainName)
        guard let notificationName = os_eligibility_get_domain_notification_name(domainType) else {
            throw POSIXError(.EINVAL)
        }
        print(String(cString: notificationName))
    }
}
