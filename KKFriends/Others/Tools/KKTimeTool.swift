//
//  KKTimeTool.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKTimeTool: NSObject {
    //时间转时间字符格式00:00
    class func getFormateTime(_ time:TimeInterval) -> String {
        return String(format: "%02d:%02d", Int(time) / 60,Int(time) % 60)
    }
    class func getTimeWithString(_ timeString:String) -> TimeInterval{
        //分割
        let minSec = timeString.components(separatedBy: ":")
        if minSec.count != 2 {
            return 0
        }
        
        let min = TimeInterval(minSec[0]) ?? 0
        let sec = TimeInterval(minSec[1]) ?? 0
        return min * 60 + sec
    }
    
}
