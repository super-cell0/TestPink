//
//  ViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/18.
//

import UIKit
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController {

    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        
        //selectedBar的UI
        self.settings.style.selectedBarBackgroundColor = UIColor(named: "mainColor")!
        self.settings.style.selectedBarHeight = 3
        
        self.settings.style.buttonBarItemBackgroundColor = .clear
        self.settings.style.buttonBarItemTitleColor = .label
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        
        self.settings.style.buttonBarMinimumInteritemSpacing = 10
        self.settings.style.buttonBarMinimumLineSpacing = 20
        self.settings.style.buttonBarLeftContentInset = 115
        self.settings.style.buttonBarRightContentInset = 115
        self.settings.style.buttonBarItemLeftRightMargin = 0
        //self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        super.viewDidLoad()
        
        //改变选中过后selectedBar的颜色
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label

            if animated {
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            } else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
        
        //左右View距离侧边屏幕的滑动效果
        self.containerView.bounces = false
        
//        DispatchQueue.main.sync {
//            self.moveToViewController(at: 1, animated: true)
//        }

    }
    
//    override func calculateStretchedCellWidths(_ minimumCellWidths: [CGFloat], suggestedStretchedCellWidth: CGFloat, previousNumberOfLargeCells: Int) -> CGFloat {
//        return 10
//    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let discoveryVC = self.storyboard!.instantiateViewController(identifier: kDiscoveryVCID)
        let followVC = self.storyboard!.instantiateViewController(identifier: kFollowVCID)
        let nearByVC = self.storyboard!.instantiateViewController(identifier: kNearByVCID)
        
        return [discoveryVC, followVC, nearByVC]
    }
    
    
}


