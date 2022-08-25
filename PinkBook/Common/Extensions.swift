//
//  Extensions.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/20.
//

import UIKit

extension UIView {
    @IBInspectable
    var setRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

