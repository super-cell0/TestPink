//
//  Extensions.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/20.
//

import UIKit
import MBProgressHUD

extension UITextField {
    var unwrappedText: String { text ?? "" }
}

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

extension UIViewController {
    ///提示框-可选择样式
    func showTextHUD(HeaderTitle title: String, subTitle sTitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = sTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    ///点击空白处关闭键盘
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

//extension Bundle{
//    var appName: String{
//        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
//            return appName
//        }else{
//            return infoDictionary!["CFBundleDisplayName"] as! String
//        }
//    }
//}

