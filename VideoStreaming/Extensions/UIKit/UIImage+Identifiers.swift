//
//  UIImage+Identifiers.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case play = "Play"
        case pause = "Pause"
        case settings = "Settings"
    }
    
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}
