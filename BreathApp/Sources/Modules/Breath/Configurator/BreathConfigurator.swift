//
//  BreathConfigurator.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 7/2/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit


class BreathConfigurator {
    
    enum Constants {
        static let storyboardTitle = "Breath"
    }
    
    let storyboard: UIStoryboard
    let animations: [AnimationPhase]
    
    init(storyboard: UIStoryboard, animations: [AnimationPhase]) {
        self.storyboard = storyboard
        self.animations = animations
    }
    
    func makeModule() -> BreathViewController {
        let viewController = storyboard
            .instantiateViewController(withIdentifier: String(describing: BreathViewController.self))
            as! BreathViewController
        configureModule(with: viewController)
        return viewController
    }
    
}

private extension BreathConfigurator {
    
    func configureModule(with viewController: BreathViewController) {
        let presenter = BreathPresenter(animations: animations)
        presenter.view = viewController
        
        viewController.output = presenter
    }
    
}
