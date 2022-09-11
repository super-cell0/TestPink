//
//  TextViewAccessoryView.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/9/7.
//

import UIKit

class TextViewAccessoryView: UIView {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView! {
        didSet {
            textCountStackView.isHidden = true
        }
    }
    @IBOutlet weak var textCountLabel: UILabel! {
        didSet {
            textCountLabel.text = "\(0)"
        }
    }
    @IBOutlet weak var maxTextCountLabel: UILabel!
    
    var currentTextCount = 0 {
        didSet {
            if currentTextCount <= kMaxNoteTextViewCount {
                doneButton.isHidden = false
                textCountStackView.isHidden = true
            } else {
                doneButton.isHidden = true
                textCountStackView.isHidden = false
                textCountLabel.text = "\(currentTextCount)"
            }
        }
    }
}
