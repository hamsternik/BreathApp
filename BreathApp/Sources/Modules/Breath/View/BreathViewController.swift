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
    
    @IBOutlet weak var breathingSquaredView: UIView!
    @IBOutlet weak var animationTypeLabel: UILabel!
    @IBOutlet weak var animationRemainingTimeLabel: UILabel!
    @IBOutlet weak var totalAnimationRemainingTimeLabel: UILabel!
    
    lazy var breathActionTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(BreathViewController.didTapOnSquaredView))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breathingSquaredView.addGestureRecognizer(breathActionTapRecognizer)
        output.viewIsReady()
    }
    
    @objc func didTapOnSquaredView(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .recognized {
            output.didTapOnSquaredView()
        }
    }
    
}

extension BreathViewController: BreathViewInput {
    
    func setAnimationType(_ animationType: String?) {
        onMain { [animationTypeLabel] in animationTypeLabel?.text = animationType }
    }
    
    func setAnimationRemainingTime(_ remainingTime: String?) {
        onMain { [animationRemainingTimeLabel] in animationRemainingTimeLabel?.text = remainingTime }
    }
    
    func setAllAnimationsRemainingTime(_ remainingTime: String?) {
        onMain { [totalAnimationRemainingTimeLabel] in totalAnimationRemainingTimeLabel?.text = remainingTime }
    }
    
    func setAnimationScaleFactor(_ scale: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.breathingSquaredView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func setAnimationColor(_ color: UIColor) {
        onMain { [breathingSquaredView] in breathingSquaredView?.backgroundColor = color }
    }
    
}
