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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    ///限制title的字数
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
        
        self.titleCountLabel.isHidden = true
        //滑动页面关闭键盘
        scrollView.keyboardDismissMode = .onDrag
        titleTextField.delegate = self
        hideKeyboardWhenTappedAround()
        titleCountLabel.text = String(kMaxNoteTitleCount)
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func textFieldEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }
    @IBAction func textFieldEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }
    @IBAction func textFieldEndOnExit(_ sender: Any) {
    }
    //实时显示可输入的字数
    @IBAction func textFieldEditChanged(_ sender: Any) {
        titleCountLabel.text = String(kMaxNoteTitleCount - titleTextField.unwrappedText.count)
    }
}

extension NoteEditViewController: UITextFieldDelegate {
    //textFieldEndOnExit与下面的方法实现功能一样
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()//软键盘消失
//        return true
//    }
    //标题达到字数限制后限制输入
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //print(textField)//当前输入的文本
        //print(range)//字符索引
        //print(string)//当前输入的字符
        //return titleTextField.unwrappedText.count > 5 ? false : true//返回后不能删除
        if range.location >= kMaxNoteTitleCount || (textField.unwrappedText.count + string.count) > kMaxNoteTitleCount {
            showTextHUD(HeaderTitle: "标题最多输入\(kMaxNoteTitleCount)个字符")
            return false
        }
        return true
        //if语句取反也可以
    }
}
