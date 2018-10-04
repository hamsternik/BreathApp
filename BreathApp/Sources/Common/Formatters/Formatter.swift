//
//  Formatter.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 10/4/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

protocol Formatter {
    
    associatedtype Input
    associatedtype Output
    
    func format(from input: Input) -> Output
    
}
