//
//  BreathingSquaredViewModel.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit

struct BreathingSquaredViewModel {
    
    struct Duration {
        
        enum DisplayMode {
            case disable, enable
        }
        
        var value: TimeInterval
        var mode: DisplayMode
        
    }
    
    var animationTypeText: String?
    var duration: Duration?
    var scaleFactor: CGFloat?
    var backgroundColor: UIColor?
    
    private var remainingTimeFormatter: AnyStringFormatter<TimeInterval> = AnyStringFormatter(CountdownTimeFormatter())
    
    init(
        animationTypeText: String?,
        duration: Duration?,
        scaleFactor: CGFloat?,
        backgroundColor: UIColor?,
        remainingTimeFormatter: AnyStringFormatter<TimeInterval> = AnyStringFormatter(CountdownTimeFormatter())
    ) {
        self.animationTypeText = animationTypeText
        self.duration = duration
        self.scaleFactor = scaleFactor
        self.backgroundColor = backgroundColor
        self.remainingTimeFormatter = remainingTimeFormatter
    }
    
    private func applyRemainingTime(_ value: TimeInterval, on view: BreathViewInput) {
        Countdown(duration: value).fire { [remainingTimeFormatter] remainingTime in
            let remainingTimeText = remainingTimeFormatter.format(from: remainingTime)
            view.setAnimationRemainingTime(remainingTimeText)
        }
    }
    
}

extension BreathingSquaredViewModel {
    
    func apply(on view: BreathViewInput) {
        view.setAnimationType(animationTypeText)
        
        if let duration = duration {
            switch duration.mode {
            case .enable: applyRemainingTime(duration.value, on: view)
            case .disable: view.setAnimationRemainingTime(nil)
            }
            
            scaleFactor.map { view.setAnimationScaleFactor($0, duration: duration.value) }
        }
        
        backgroundColor.map { view.setAnimationColor($0) }
    }
    
}
