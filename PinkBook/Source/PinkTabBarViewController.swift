//
//  PinkTabBarViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/18.
//

import UIKit
import YPImagePicker

class PinkTabBarViewController: UITabBarController {

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

extension PinkTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let vc = viewController as? PostViewController {
            
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
            config.library.maxNumberOfItems = 9
            config.library.minNumberOfItems = 1
            config.library.numberOfItemsInRow = 4
            config.library.spacingBetweenItems = 1.0
            config.library.skipSelectionsGallery = false
            config.library.preselectedItems = nil
            config.library.preSelectItemOnMultipleSelection = true//多选的时候预选第一张图片
            
            let picker = YPImagePicker(configuration: config)

            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    print(photo.fromCamera) // Image source (camera or library)
                    print(photo.image) // Final image selected by the user
                    print(photo.originalImage) // original image selected by the user, unfiltered
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
}
