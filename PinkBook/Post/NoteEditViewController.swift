//
//  NoteEditViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/21.
//

import UIKit

class NoteEditViewController: UIViewController {
    
    //var videoURL: URL = Bundle.main.url(forResource: "testVideo", withExtension: ".mp4")!
    var videoURL: URL?
    var isVideo: Bool { videoURL != nil }
    ///当前展示的照片数量
    var photoCount: Int{ photos.count }
    ///存储展示照片的数组
    var photos = [
        UIImage(named: "1")!, UIImage(named: "2")!
    ]
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.showsVerticalScrollIndicator = false
        self.photoCollectionView.showsHorizontalScrollIndicator = false
        self.photoCollectionView.dragDelegate = self
        self.photoCollectionView.dropDelegate = self
        self.photoCollectionView.dragInteractionEnabled = true
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

