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
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
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
        let presenter = BreathPresenter()
        presenter.view = viewController
        
        viewController.output = presenter
    }
    
}
