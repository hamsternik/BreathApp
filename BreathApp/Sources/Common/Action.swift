//
//  Action.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

protocol Action {
    func perform()
}

class DeferredAction: Action {
    
    typealias ActionType = () -> Void
    
    let action: ActionType
    
    init(action: @escaping ActionType) {
        self.action = action
    }
    
    func perform() {
        action()
    }
    
}
