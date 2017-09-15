//
//  KKLrcController.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/15.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKLrcController: UITableViewController {

    let cellID = "KKLrcCell"
    
    var lrcMs:[KKLrcModel] = [KKLrcModel](){
        didSet{
            tableView.reloadData()
        }
    }
    var scrollRow = -1{
        didSet{
            if scrollRow == oldValue {
                return
            }
            tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.fade)
            tableView.scrollToRow(at:IndexPath(row: scrollRow, section: 0), at: UITableViewScrollPosition.middle, animated: true)
        }
    }
    var progress:CGFloat = 0{
        didSet{

            let cell = tableView.cellForRow(at:IndexPath(row: scrollRow, section: 0)) as? KKLrcCell
            cell?.progress = progress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - Table view data source
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcMs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? KKLrcCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("KKLrcCell ", owner: self, options: nil)?.first as? KKLrcCell
        }
        // Configure the cell...
//        if indexPath.row == scrollRow {
//            cell?.progress = progress
//        }else{
//            cell?.progress = 0
//        }
        cell?.lrcContent = lrcMs[indexPath.row].lrcContent
        return cell!
    }
 
}
