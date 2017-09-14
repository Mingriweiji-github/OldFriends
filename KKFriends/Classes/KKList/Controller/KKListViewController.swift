//
//  KKListViewController.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKListViewController: UITableViewController {

    let cellID = "KKMusicCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI(){
        tableView.rowHeight = 60
//        tableView.backgroundView = UIImageView.init(image: UIImage(named: ""))
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none

        let nib = UINib(nibName: String(describing:KKMusicCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        
        navigationController?.isNavigationBarHidden = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? KKMusicCell
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed("KKMusicCell", owner: nil, options: nil)?.first as? KKMusicCell
        }
        return cell!
    }
    
    
}
