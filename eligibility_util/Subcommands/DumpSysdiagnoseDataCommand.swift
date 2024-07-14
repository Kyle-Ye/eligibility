//
//  DumpSysdiagnoseDataCommand.swift
//  eligibility
//
//  Created by Kyle on 2024/7/14.
//

import ArgumentParser
import Foundation

struct DumpSysdiagnoseDataCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "dumpSysdiagnoseData"
    )
    
    @Argument(help: "The directory to dump the sysdiagnose data to")
    private var dir: String
    
    func run() throws {
        let result = os_eligibility_dump_sysdiagnose_data_to_dir(dir)
        if result == 0 {
            print("Dump sysdiagnose data to \(dir) successfully")
        } else {
            print("Dump sysdiagnose data failed: errorNum \(result)")
        }
    }
}
