//
//  BreathViewState.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation
import CoreGraphics
import UIColor_Hex_Swift

enum BreathViewState {
    case idle(duration: TimeInterval)
    case active(phase: AnimationPhase)
}

extension BreathViewState {
    
    var viewModel: BreathViewModel {
        switch self {
        case .idle(let stateDuration):
            return makeIdleStateViewModel(with: stateDuration)
        case .active(let phase):
            return makeActiveStateViewModel(with: phase)
        }
    }
    
    private func makeIdleStateViewModel(with duration: TimeInterval) -> BreathViewModel {
        return BreathViewModel(
            animationType: nil,
            animationRemainingTime: nil,
            totalRemainingTime: nil,
            scaleFactor: 0.75,
            backgroundColor: UIColor("#0x7A83F2", defaultColor: .white)
        )
    }
    
    private func makeActiveStateViewModel(with animationPhase: AnimationPhase) -> BreathViewModel {
        var activeViewModel = BreathViewModel(
            animationType: "\(animationPhase.type.rawValue)",
            animationRemainingTime: "\(animationPhase.duration)",
            totalRemainingTime: nil, // FIXME: Replace this with a real value
            scaleFactor: nil, // FIXME: Replace this with a constant
            backgroundColor: animationPhase.color
        )
        
        switch animationPhase.type {
        case .exhale:
            activeViewModel.scaleFactor = 1.0
        case .inhale:
            activeViewModel.scaleFactor = 0.5
        case .hold:
            break
        }
        
        return activeViewModel
    }
    
}
