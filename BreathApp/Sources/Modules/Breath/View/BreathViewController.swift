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
    
    @IBOutlet private weak var animatedSquareView: UIView!
    @IBOutlet private weak var animationTypeLabel: UILabel!
    @IBOutlet private weak var animationRemainingTimeLabel: UILabel!
    @IBOutlet private weak var totalAnimationRemainingTimeLabel: UILabel!
    
    lazy var squareViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(BreathViewController.didTapOnSquareView))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animatedSquareView.addGestureRecognizer(squareViewTapRecognizer)
        output.viewIsReady()
    }
    
    @objc func didTapOnSquareView(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .recognized {
            output.didTapOnSquaredView()
        }
    }
    
}


extension BreathViewController: BreathViewInput {
    
    func setAnimationType(_ animationType: String?) {
        self.animationTypeLabel.text = animationType
    }
    
    func setAnimationRemainingTime(_ remainingTime: String?) {
        self.animationRemainingTimeLabel.text = remainingTime
    }
    
    func setAllAnimationsRemainingTime(_ remainingTime: String?) {
        self.totalAnimationRemainingTimeLabel.text = remainingTime
    }
    
    func setAnimationScaleFactor(_ scale: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.animatedSquareView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func setAnimationColor(_ color: UIColor) {
        self.animatedSquareView.backgroundColor = color
    }
    
}
