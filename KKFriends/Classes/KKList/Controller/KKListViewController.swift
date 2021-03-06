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
    var musicMs = [KKMusicModel](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        KKMusicDataManager.getMusicMs { (models:[KKMusicModel]) in
            self.musicMs = models
            KKMusicOperationTool.sharedInstance.musicMs = models
        }
    }
    func setupUI(){
        tableView.rowHeight = 60
        tableView.backgroundView = UIImageView.init(image: UIImage(named: "backBg.jpg"))
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none

        let nib = UINib(nibName: String(describing:KKMusicCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        
        navigationController?.isNavigationBarHidden = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicMs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? KKMusicCell
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed("KKMusicCell", owner: nil, options: nil)?.first as? KKMusicCell
        }
        cell?.animation(AnimationType.scale)
        cell?.musicM = musicMs[indexPath.row]
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KKMusicOperationTool.sharedInstance.musicMs = musicMs
        KKMusicOperationTool.sharedInstance.playMusicWithModel(musicMs[(indexPath as NSIndexPath).row])
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "KKDetailVC")
        navigationController?.present(detailVC, animated: true, completion: nil)
    }
    
}
