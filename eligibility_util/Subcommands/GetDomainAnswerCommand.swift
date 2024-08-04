//
//  GetDomainAnswerCommand.swift
//  eligibility_util
//
//  Created by Kyle on 2024/7/7.
//

import ArgumentParser
import Foundation

struct GetDomainAnswerCommand: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "getDomainAnswer"
    )
    
    @OptionGroup(title: "The domain to query answer")
    private var domain: DomainArguments
    
    @Flag(
        name: [
            .customLong("all"),
            .customShort("a"),
        ],
        help: "query all answers"
    )
    private var queryAll = false
    
    func run() throws {
        if queryAll {
            try handleGetAllDomainAnswers()
        } else {
            try handleGetDomainAnswer()
        }
    }
    
    private func handleGetDomainAnswer() throws {
        var answer: EligibilityAnswer = .invalid
        var source: EligibilityAnswerSource = .invalid
        var status: xpc_object_t?
        var context: xpc_object_t?
        let result = os_eligibility_get_domain_answer(domain.type, &answer, &source, &status, &context)
        guard result == 0 else {
            if let posixErrorCode = POSIXErrorCode(rawValue: result) {
                throw POSIXError(posixErrorCode)
            } else {
                throw NSError()
            }
        }
        let answerString = switch answer {
            case .invalid: "OS_ELIGIBILITY_ANSWER_INVALID"
            case .notYetAvailable: "OS_ELIGIBILITY_ANSWER_NOT_YET_AVAILABLE"
            case .notEligible: "OS_ELIGIBILITY_ANSWER_NOT_ELIGIBLE"
            case .maybe: "OS_ELIGIBILITY_ANSWER_MAYBE"
            case .eligible: "OS_ELIGIBILITY_ANSWER_ELIGIBLE"
            default: "Unsupported answer type: \(answer)"
        }
        print(answerString)
    }
    
    private func handleGetAllDomainAnswers() throws {
        var answers: xpc_object_t?
        let result = os_eligibility_get_all_domain_answers(&answers)
        guard let answers,
              result == 0 else {
            if let posixErrorCode = POSIXErrorCode(rawValue: result) {
                throw POSIXError(posixErrorCode)
            } else {
                throw NSError(domain: POSIXError.errorDomain, code: -1)
            }
        }
        let type = xpc_get_type(answers)
        guard type == XPC_TYPE_DICTIONARY else {
            print("xpc message type must be a dictionary")
            throw NSError(domain: POSIXError.errorDomain, code: -1)
        }
        // The `_CFXPCCreateCFObjectFromXPCObject` implementation from xpc_private.h will give us nil result
        // Use darling-corefoundation's open source implementation as a fallback implementation
        guard let cfObject = _CFXPCCreateCFObjectFromXPCObject(answers) ?? _OpenCFXPCCreateCFObjectFromXPCObject(answers),
              let answersDictionary = cfObject.takeUnretainedValue() as? NSDictionary else {
            print("Failed to convert the answers reply into CF objects")
            throw NSError(domain: POSIXError.errorDomain, code: -1)
        }
        print(answersDictionary)
    }
    
    func validate() throws {
        if queryAll {
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
