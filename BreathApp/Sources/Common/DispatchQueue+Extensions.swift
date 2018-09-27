//
//  DispatchQueue+Extensions.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/27/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

func onMain(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}
