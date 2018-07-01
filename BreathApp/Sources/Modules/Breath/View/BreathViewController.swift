//
//  BreathViewController.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 7/1/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit


class BreathViewController: UIViewController {
    
    var output: BreathViewOutput!
    
    @IBOutlet private weak var generalAnimationCountdownLabel: UILabel!
    @IBOutlet private weak var currentAnimationCountdownLabel: UILabel!
    @IBOutlet private weak var currentAnimationPhaseLabel: UILabel!
    @IBOutlet private weak var animatedSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
}


extension BreathViewController: BreathViewInput {
    
}
