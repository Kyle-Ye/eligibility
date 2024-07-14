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
    
    @OptionGroup(title: "The domain to query notification name")
    private var domain: DomainArguments

    func run() throws {
        guard let notificationName = os_eligibility_get_domain_notification_name(domain.type) else {
            throw POSIXError(.EINVAL)
        }
        print(String(cString: notificationName))
    }
}
