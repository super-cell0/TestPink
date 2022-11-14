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
    ///加载框-手动隐藏
    func showLoadHUD(_ title: String? = nil ) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = title
    }
    ///加载框-手动隐藏
    func hideLoadHUD() {
        //ui操作放在主线程执行
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    ///提示框-可选择样式-自动隐藏
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

extension Bundle{
//    var appName: String{
//        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
//            return appName
//        }else{
//            return infoDictionary!["CFBundleDisplayName"] as! String
//        }
//    }
    
    // MARK: 静态属性和方法--1.直接用类名进行调用,2.省资源
    // MARK: static和class的区别
    //static能修饰class/struct/enum的存储属性、计算属性、方法;class能修饰类的计算属性和方法
    //static修饰的类方法不能继承；class修饰的类方法可以继承
    //在protocol中要使用static
    //加载xib上的view
    //为了更通用，使用泛型。as?后需接类型，故形式参数需为T.Type，实质参数为XXView.self--固定用法
    static func loadInputAccessoryView<T>(formXibName name: String, withType type: T.Type ) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        } else {
            fatalError("xibView\(type)加载失败")
        }
    }
}

