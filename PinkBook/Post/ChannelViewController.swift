//
//  ChannelViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/9/12.
//

import UIKit
import XLPagerTabStrip

class ChannelViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        
        //selectedBar的UI
        self.settings.style.selectedBarBackgroundColor = UIColor(named: "mainColor")!
        self.settings.style.selectedBarHeight = 3
        
        self.settings.style.buttonBarItemBackgroundColor = .clear
        self.settings.style.buttonBarItemTitleColor = .label
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        
        self.settings.style.buttonBarMinimumInteritemSpacing = 10
        self.settings.style.buttonBarMinimumLineSpacing = 20
        self.settings.style.buttonBarLeftContentInset = 16
        self.settings.style.buttonBarRightContentInset = 16
        self.settings.style.buttonBarItemLeftRightMargin = 0
        //self.settings.style.buttonBarItemsShouldFillAvailableWidth = true

        super.viewDidLoad()
        //self.view.backgroundColor = .opaqueSeparator
        // Do any additional setup after loading the view.
    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs: [UIViewController] = []
        for i in kChannels.indices {
            let vc = storyboard?.instantiateViewController(identifier: kChannelTableViewControllerID) as! ChannelTableViewController
            vc.channel = kChannels[i]
            vc.subChannel = kAllSubChannels[i]
            vcs.append(vc)
        }
        return vcs
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
