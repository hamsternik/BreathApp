//
//  AnimationPhase.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

struct AnimationPhase: Equatable {
    
    enum AnimationPhaseType: String, Decodable {
        case inhale, exhale, hold
    }
    
    let type: AnimationPhaseType
    let duration: TimeInterval
    let color: UIColor
    
}

extension AnimationPhase: Decodable {
    
    enum DecodingKeys: String, CodingKey {
        case type, duration, color
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.type = try container.decode(AnimationPhaseType.self, forKey: .type)
        self.duration = try container.decode(TimeInterval.self, forKey: .duration)
        let colorHexString = try container.decode(String.self, forKey: .color)
        self.color = try UIColor(rgba_throws: colorHexString)
    }
    
}
