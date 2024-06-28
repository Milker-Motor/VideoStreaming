//
//  UIVIew+Init.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit

extension UIView {
    static func fromNib<T: UIView>() -> T {
        guard let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T else {
            fatalError("\(T.self) nib unwrap")
        }
        return view
    }
}
