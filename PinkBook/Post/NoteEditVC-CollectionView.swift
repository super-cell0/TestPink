//
//  NoteEditVC-CollectionView.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/29.
//

import UIKit
import YPImagePicker
import AVKit
import MBProgressHUD
import SKPhotoBrowser


extension NoteEditViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionViewCellID, for: indexPath) as! PhotoCollectionViewCell
        
        cell.photoImageView.image = photos[indexPath.item]
        
        return cell
    }
    
    //MARK: -viewForSupplementaryElementOfKind
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
    
    //MARK: -选取展示预览图
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isVideo {
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoURL! )
            present(playerVC, animated: true) {
                //单独传一个视频需要play()才能播放
                playerVC.player?.play()
            }
        } else {
            // 1. create SKPhoto Array from UIImage
            var images: [SKPhoto] = []
            for photo in photos {
                images.append(SKPhoto.photoWithImage(photo))
            }
            // 2. create PhotoBrowser Instance, and present from your viewController.
            //let browser = SKPhotoBrowser(photos: images)
            //browser.initializePageIndex(indexPath.item)
            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            
            browser.delegate = self
            SKPhotoBrowserOptions.displayAction = false
            SKPhotoBrowserOptions.displayDeleteButton = true
            present(browser, animated: true, completion: nil)
        }
    }
    
}

extension NoteEditViewController: SKPhotoBrowserDelegate {
    
    //MARK: -预览的照片
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        
        photoCollectionView.reloadData()
        reload()
    }
}

extension NoteEditViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
}

//MARK: -监听函数
extension NoteEditViewController {
    @objc private func addPhoto() {
        //print("addphoto")
        if photoCount < kPhotoCount {
            
            var config = YPImagePickerConfiguration()
            //MARK: -通用配置
            config.usesFrontCamera = false//后置摄像头
            config.shouldSaveNewPicturesToAlbum = true//选择或拍摄完照片下一步后自动保存
            config.albumName = "PinkBook"//保存相册后的app名称

            config.screens = [.library ]//展示的model
            config.showsCrop = .none//裁剪
            config.targetImageSize = YPImageSize.original
            config.overlayView = UIView()//在相机上面添加视图
            config.hidesBottomBar = false
            config.hidesCancelButton = false
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            
            //MARK: -相册配置
            config.library.options = nil
            config.library.onlySquare = false
            config.library.isSquareByDefault = true
            config.library.minWidthForItem = nil
            config.library.mediaType = YPlibraryMediaType.photo
            config.library.defaultMultipleSelection = true//多选按钮的初始状态。
            config.library.maxNumberOfItems = 9 - photoCount//最大选择照片数量
            config.library.minNumberOfItems = 1//最小选择照片数量
            config.library.numberOfItemsInRow = 4
            config.library.spacingBetweenItems = 2.0
            config.library.skipSelectionsGallery = false//选择多个照片后是否跳过编辑页面
            config.library.preselectedItems = nil
            config.library.preSelectItemOnMultipleSelection = true//多选的时候预选第一张图片
            
            //MARK: -视频配置
            config.video.compression = AVAssetExportPresetHighestQuality
            config.video.fileType = .mov
            config.video.recordingTimeLimit = 60.0
            config.video.libraryTimeLimit = 60.0//视频max长度
            config.video.minimumTimeLimit = 3.0//视频min长度
            config.video.trimmerMaxDuration = 60.0//剪辑的最长时长
            config.video.trimmerMinDuration = 3.0
            
            config.gallery.hidesRemoveButton = false//多选照片后进入编辑页面 可以删除照片
            
            let picker = YPImagePicker(configuration: config)

            picker.didFinishPicking { [unowned picker] items, _ in
                
                //把本地照片加到photos里面
                for item in items {
                    if case let .photo(photo) = item {
                        self.photos.append(photo.image)
                    }
                }
                self.photoCollectionView.reloadData()

                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)

        } else {
            //print("nononono")
            self.showTextHUD(HeaderTitle: "最多只能选择\(9)张照片")
            //自己写一个会自动消失的alterController
        }
    }
}
