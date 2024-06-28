//
//  NSObject+Common.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import Foundation

extension NSObject {
    /// To present class in string.
    static var classString: String {
        return String(describing: self.self)
    }
}
