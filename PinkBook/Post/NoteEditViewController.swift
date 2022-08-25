//
//  NoteEditViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/21.
//

import UIKit

class NoteEditViewController: UIViewController {

    let photos = [
        UIImage(named: "1"), UIImage(named: "2")
    ]
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.showsVerticalScrollIndicator = false
        self.photoCollectionView.showsHorizontalScrollIndicator = false
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

extension NoteEditViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionViewCellID, for: indexPath) as! PhotoCollectionViewCell
        
        cell.photoImageView.image = photos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterCollectionReusableViewID, for: indexPath) as! PhotoFooterCollectionReusableView
            
            photoFooter.addPhotoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            return photoFooter
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension NoteEditViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
}

extension NoteEditViewController {
    @objc private func addPhoto() {
        print("addphoto")
    }
}
