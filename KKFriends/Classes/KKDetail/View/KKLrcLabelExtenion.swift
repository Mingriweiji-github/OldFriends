//
//  KKLrcLabelExtenion.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/15.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
class KKLrcLabelExtenion: UILabel {
    
    var progress:CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //填充色值
        UIColor.green.set()
        //label颜色混合填充
        UIRectFillUsingBlendMode(CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width * progress, height: rect.size.height), CGBlendMode.sourceIn)
    }
    
}
