//
//  BreathViewInterface.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 7/2/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit

protocol BreathViewInput: class {
    
    var output: BreathViewOutput! { get set }
    
    func setAnimationType(_ animationType: String?)
    func setAnimationRemainingTime(_ remainingTime: String?)
    func setAllAnimationsRemainingTime(_ remainingTime: String?)
    func setAnimationScaleFactor(_ scale: CGFloat, duration: TimeInterval)
    func setAnimationColor(_ color: UIColor)
    
}

protocol BreathViewOutput {
    
    func viewIsReady()
    func didTapOnSquaredView()
    
}
