//
//  BreathPresenter.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 7/2/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation


class BreathPresenter {
    
    weak var view: BreathViewInput!
    
    private var animations = [AnimationPhase]()
    
    init(animations: [AnimationPhase]) {
        self.animations = animations
    }
    
}

extension BreathPresenter: BreathViewOutput {
    
    func viewIsReady() {
        // TBD
    }
    
}
