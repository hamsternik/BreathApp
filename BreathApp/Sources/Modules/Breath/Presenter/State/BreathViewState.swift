//
//  BreathViewState.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

enum BreathViewState {
    
    case idle
    case transition(duration: TimeInterval)
    case animation(phase: AnimationPhase)
}

// MARK: - BreathingSquaredViewModel State ViewModel

extension BreathingSquaredViewModel {
    
    static let idleStateViewModel = BreathingSquaredViewModel(
        animationTypeText: "tap here\n to breath".uppercased(),
        remainingTime: (value: 0, text: nil),
        scaleFactor: nil,
        backgroundColor: UIColor("#FFFC79", defaultColor: .yellow)
    )
    
    static func transitionViewStateViewModel(scale: CGFloat, duration: TimeInterval, color: UIColor) -> BreathingSquaredViewModel {
        return BreathingSquaredViewModel(
            animationTypeText: nil,
            remainingTime: (value: duration, text: nil),
            scaleFactor: scale,
            backgroundColor: color
        )
    }
    
}
