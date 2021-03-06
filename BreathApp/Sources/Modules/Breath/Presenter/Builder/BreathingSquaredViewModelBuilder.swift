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
        static let transitionBackgroundColor: UIColor = .lightGray
    }
    
    func build(for state: BreathViewState) -> BreathingSquaredViewModel {
        switch state {
        case .idle:
            return makeIdleStateViewModel()
        case .transition(let duration, let scale):
            return makeTransitionStateViewModel(with: duration, scaleFactor: scale)
        case .animation(let phase):
            return makeActiveStateViewModel(with: phase)
        }
    }
    
    private func makeIdleStateViewModel() -> BreathingSquaredViewModel {
        return .idleStateViewModel
    }
    
    private func makeTransitionStateViewModel(with duration: TimeInterval, scaleFactor: CGFloat) -> BreathingSquaredViewModel {
        return BreathingSquaredViewModel.transitionViewStateViewModel(
            scale: scaleFactor,
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
            duration: BreathingSquaredViewModel.Duration(value: animationPhase.duration, mode: .enable),
            scaleFactor: animationPhaseType(animationPhase.type),
            backgroundColor: UIColor(animationPhase.color, defaultColor: .white)
        )
    }
    
}
