//
//  MockBreathViewOutput.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class MockBreathViewOutput: BreathViewOutput {
    
    private(set) var viewIsReadyValue: Bool = false
    private(set) var didTapOnSquaredViewValue: Bool = false
    
    func viewIsReady() {
        viewIsReadyValue = true
    }
    
    func didTapOnSquaredView() {
        didTapOnSquaredViewValue = true
    }
    
}
