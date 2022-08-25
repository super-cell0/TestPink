//
//  PinkTabBarViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/18.
//

import UIKit
import YPImagePicker
import AVKit

class PinkBookTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor(named: "mainColor")
        self.delegate = self
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

extension PinkBookTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let _ = viewController as? PostViewController {
            
            //MARK: -待做登陆判断
            
            var config = YPImagePickerConfiguration()
            //MARK: -通用配置
            config.isScrollToChangeModesEnabled = false//切换的手势
            config.onlySquareImagesFromCamera = false//正方形照片
            config.usesFrontCamera = false//后置摄像头
            config.shouldSaveNewPicturesToAlbum = true//选择或拍摄完照片下一步后自动保存
            config.albumName = "PinkBook"//保存相册后的app名称
            //Bundle.main.infoDictionary
            //Bundle.main.localizedInfoDictionary//本地化后名称
            
            config.startOnScreen = YPPickerScreen.library//默认展示相册
            config.screens = [.library, .photo, .video]//展示的model
            config.showsCrop = .none//裁剪
            config.targetImageSize = YPImageSize.original
            config.overlayView = UIView()//在相机上面添加视图
            config.hidesBottomBar = false
            config.hidesCancelButton = false
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            config.maxCameraZoomFactor = 5.0//相机变焦指数
            
            //MARK: -相册配置
            config.library.options = nil
            config.library.onlySquare = false
            config.library.isSquareByDefault = true
            config.library.minWidthForItem = nil
            config.library.mediaType = YPlibraryMediaType.photo
            config.library.defaultMultipleSelection = true//多选按钮的初始状态。
            config.library.maxNumberOfItems = 9//最大选择照片数量
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

            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    print("用户点击了左上角取消按钮")
                }
                for item in items {
                    switch item {
                    case let .photo(photo):
                        print(photo)
                    case .video(let video):
                        print(video)

                    }
                }
//                if let photo = items.singlePhoto {
//                    print(photo.fromCamera) // Image source (camera or library)
//                    print(photo.image) // Final image selected by the user
//                    print(photo.originalImage) // original image selected by the user, unfiltered
//                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
    
}
