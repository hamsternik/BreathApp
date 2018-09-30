//
//  AnimationPhase.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

struct AnimationPhase: Equatable {
    
    enum AnimationPhaseType: String, Decodable {
        case inhale, exhale, hold
    }
    
    let type: AnimationPhaseType
    let duration: TimeInterval
    let color: String
    
}

extension AnimationPhase: Decodable {
    
    enum DecodingKeys: String, CodingKey {
        case type, duration, color
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.type = try container.decode(AnimationPhaseType.self, forKey: .type)
        self.duration = try container.decode(TimeInterval.self, forKey: .duration)
        self.color = try container.decode(String.self, forKey: .color)
    }
    
}

extension Array where Element == AnimationPhase {
    
    var duration: TimeInterval {
        return self.reduce(0) { $0 + $1.duration }
    }
    
}
