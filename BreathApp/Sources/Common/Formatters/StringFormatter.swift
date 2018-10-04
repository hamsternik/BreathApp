//
//  StringFormatter.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 10/4/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

protocol StringFormatter: Formatter where Output == String? {}

struct AnyStringFormatter<I>: StringFormatter {
    
    private let _format: (I) -> String?
    
    init<SF>(_ base: SF) where SF: StringFormatter, SF.Input == I {
        _format = base.format
    }
    
    func format(from input: I) -> String? {
        return _format(input)
    }
    
}
