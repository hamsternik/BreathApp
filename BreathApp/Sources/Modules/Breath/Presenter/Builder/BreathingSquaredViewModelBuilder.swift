//
//  BreathingSquaredViewModelBuilder.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/30/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class BreathingSquaredViewModelBuilder {
    
    enum Constants {
        static let transitionScaleFactor: CGFloat = 0.75
        static let transitionBackgroundColor: UIColor = .cyan
    }
    
    func build(for state: BreathViewState) -> BreathingSquaredViewModel {
        switch state {
        case .idle:
            return makeIdleStateViewModel()
        case .transition(let duration):
            return makeTransitionStateViewModel(with: duration)
        case .animation(let phase):
            return makeActiveStateViewModel(with: phase)
        }
    }
    
    private func makeIdleStateViewModel() -> BreathingSquaredViewModel {
        return .idleStateViewModel
    }
    
    private func makeTransitionStateViewModel(with duration: TimeInterval) -> BreathingSquaredViewModel {
        return BreathingSquaredViewModel.transitionViewStateViewModel(
            scale: Constants.transitionScaleFactor,
            duration: duration,
            color: Constants.transitionBackgroundColor
        )
    }
    
    private func makeActiveStateViewModel(with animationPhase: AnimationPhase) -> BreathingSquaredViewModel {
        
        func animationPhaseType(_ type: AnimationPhase.AnimationPhaseType) -> CGFloat? {
            switch type {
            case .exhale: return 0.5
            case .inhale: return 1.0
            case .hold: return nil
            }
        }
        
        return BreathingSquaredViewModel(
            animationTypeText: "\(animationPhase.type.rawValue)".uppercased(),
            remainingTime: (value: animationPhase.duration, text: "00:0\(Int(animationPhase.duration))"),
            scaleFactor: animationPhaseType(animationPhase.type),
            backgroundColor: UIColor(animationPhase.color, defaultColor: .white)
        )
    }
    
}
