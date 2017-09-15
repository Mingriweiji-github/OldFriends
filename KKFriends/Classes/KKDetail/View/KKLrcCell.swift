//
//  KKLrcCell.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/15.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKLrcCell: UITableViewCell {

    @IBOutlet weak var lrcLabel: KKLrcLabelExtenion!
    var progress:CGFloat = 0{
        didSet{
            lrcLabel.progress = progress
        }
    }
    var lrcContent:String = ""{
        didSet{
            lrcLabel.text = lrcContent
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
