//
//  EligibilityAnswerSourceTests.swift
//
//
//  Created by Kyle on 2024/7/2.
//

import EligibilityCore
import Testing

struct EligibilityAnswerSourceTests {
    @Test
    func invalidAnswerSource() async throws {        
        #expect(EligibilityAnswerSource.invalid.rawValue == 0)
    }
}
