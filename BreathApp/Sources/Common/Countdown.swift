//
//  Countdown.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

class Countdown {
    
    let duration: TimeInterval
    let interval: TimeInterval
    
    init(duration: TimeInterval, interval: TimeInterval = 1.0) {
        self.duration = duration
        self.interval = interval
    }
    
    @discardableResult
    func fire(bound: TimeInterval = 0.0, _ block: @escaping (_ remaining: TimeInterval) -> Void) -> Action {
        block(duration)
        
        var remainingTime: TimeInterval = duration
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { (timer) in
            remainingTime -= timer.timeInterval
            if remainingTime >= bound {
                block(remainingTime)
            } else {
                timer.invalidate()
            }
        }
        return DeferredAction {
            timer.invalidate()
        }
    }
    
}
