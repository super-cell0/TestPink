//
//  PhotoFooterCollectionReusableView.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/25.
//

import UIKit

class PhotoFooterCollectionReusableView: UICollectionReusableView {

    ///添加照片的按钮
    @IBOutlet weak var addPhotoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addPhotoButton.layer.cornerRadius = 5
        addPhotoButton.clipsToBounds = true
        addPhotoButton.layer.borderWidth = 1
        addPhotoButton.layer.borderColor = UIColor.opaqueSeparator.cgColor
    }
}
