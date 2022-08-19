//
//  WaterfallCollectionVCell.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/19.
//

import UIKit

class WaterfallCollectionVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.backgroundColor = .systemPurple
        }
    }
}
