//
//  KKMusicMessageModel.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKMusicMessageModel: NSObject {

    var music: KKMusicModel?
    var costTime:TimeInterval = 0
    var totalTime:TimeInterval = 0
    var isPlaying:Bool = false
    var costTimeFormat:String{//时间格式00：00
        get{
            return KKTimeTool.getFormateTime(costTime)
        }
    }
    
    var totalTimeForamt:String{
        get{
            return KKTimeTool.getFormateTime(totalTime)
        }
    }
}
