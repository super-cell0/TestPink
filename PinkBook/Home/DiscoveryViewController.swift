//
//  DiscoveryViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/18.
//

import UIKit
import XLPagerTabStrip

class DiscoveryViewController: ButtonBarPagerTabStripViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        
        //selectedBar的UI
        self.settings.style.selectedBarBackgroundColor = UIColor(named: "mainColor")!
        self.settings.style.selectedBarHeight = 0
        
        self.settings.style.buttonBarItemBackgroundColor = .clear
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        
        self.settings.style.buttonBarMinimumInteritemSpacing = 10
        self.settings.style.buttonBarMinimumLineSpacing = 10
        self.settings.style.buttonBarLeftContentInset = 20
        self.settings.style.buttonBarRightContentInset = 20
        self.settings.style.buttonBarItemLeftRightMargin = 0
        
        super.viewDidLoad()
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
        
        //左右View距离侧边屏幕的滑动效果
        self.containerView.bounces = false

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      return IndicatorInfo(title: "发现")
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {

        var vcChannels: [UIViewController] = []
        for channel in kChannels {
            let vc = storyboard?.instantiateViewController(identifier: kWaterfallCollectionVCID) as! WaterfallCollectionVC
            vc.channel = channel
            vcChannels.append(vc)
        }
        
        return vcChannels
    }

}
