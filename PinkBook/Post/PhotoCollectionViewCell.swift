//
//  PhotoCollectionViewCell.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/25.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    ///展示照片的imageView
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 5
            photoImageView.clipsToBounds = true
        }
    }
}
