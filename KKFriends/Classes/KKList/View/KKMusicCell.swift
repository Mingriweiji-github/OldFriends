//
//  KKMusicCell.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKMusicCell: UITableViewCell {

    @IBOutlet weak var headerImageV: UIImageView!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    var musicM: KKMusicModel? {
        didSet{
            if musicM?.singerIcon != nil {
                headerImageV.image = UIImage(named: (musicM?.singerIcon!)!)
            }
            singerNameLabel.text = musicM?.singername
            songNameLabel.text = musicM?.songname
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    
}
