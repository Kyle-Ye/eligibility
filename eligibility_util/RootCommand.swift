//
//  main.swift
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
        subcommands: [GetAnswerCommand.self]
    )
}
