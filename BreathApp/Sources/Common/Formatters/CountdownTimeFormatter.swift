//
//  CountdownTimeFormatter.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 10/4/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

struct CountdownTimeFormatter: StringFormatter {
    
    typealias Input = TimeInterval
    
    func format(from input: TimeInterval) -> String? {
        let duration = Int(input)
        let seconds = duration % 60
        let minutes = (duration / 60) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
}
