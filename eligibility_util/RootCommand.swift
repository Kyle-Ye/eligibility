//
//  RootCommand.swift
//  eligibility_util
//
//  Created by Kyle on 2024/7/7.
//

import Foundation
import ArgumentParser

@main
struct RootCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "eligibility_util",
        subcommands: [
            QueryNotificationNameCommand.self,
            SetInputCommand.self,
            ResetAnswerCommand.self,
            GetInternalStateCommand.self,
            SetTestModeCommand.self,
            GetAnswerCommand.self,
        ]
    )
}
