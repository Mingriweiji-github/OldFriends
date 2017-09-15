//
//  KKMusicCell.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
enum AnimationType {
    case rotation
    case scale
}
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
        selectionStyle = .none
        headerImageV.layer.masksToBounds = true
        headerImageV.layer.cornerRadius = headerImageV.height * 0.5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func animation(_ type:AnimationType){
//    
//        if type == .rotation {
//            self.layer.removeAnimation(forKey: "rotation")
//            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
//            animation.values = [Double.pi,0]
//            animation.duration = 0.5
//            animation.repeatCount = 1
//            self.layer.add(animation, forKey: "rotation")
//        }
        if type == .scale {
            self.layer.removeAnimation(forKey: "scale")
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.values = [0.3,0.5,0.8,1]
            animation.duration = 1
            animation.repeatCount = 1
            self.layer.add(animation, forKey: "transform.scale.x")
        }
    }
    
}
