//
//  ChannelTableViewController.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/9/12.
//

import UIKit
import XLPagerTabStrip

class ChannelTableViewController: UITableViewController {
    
    var channel = ""
    var subChannel: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView不展示内容时不显示分割线
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subChannel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSubChannelCellID, for: indexPath)

        cell.textLabel?.text = "# \(subChannel[indexPath.row])"
        cell.textLabel?.font = .systemFont(ofSize: 14)
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channelVC = parent as! ChannelViewController
        channelVC.ChannelViewDelegate?.updateChannel(channel: self.channel, subChannel: self.subChannel[indexPath.row])
        
        dismiss(animated: true)
    }
    

}

extension ChannelTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: channel)
    }
    
    
}
