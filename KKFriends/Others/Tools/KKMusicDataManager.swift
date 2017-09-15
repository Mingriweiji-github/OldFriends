//
//  KKMusicDataManager.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKMusicDataManager: NSObject {

    class func getMusicMs(_ result:([KKMusicModel]) -> ()){
        guard let plistFile = Bundle.main.path(forResource: "OldFriends.plist", ofType: nil) else {
            result ([KKMusicModel]())
            return
        }
        
        guard let array = NSArray(contentsOfFile:plistFile) else { result ([KKMusicModel]())
            return
        }
        var musicMs = [KKMusicModel]()
        for dict in array {
            let musicM = KKMusicModel(dict: dict as! [String:Any])
            musicMs.append(musicM)
        }
        
        return result(musicMs)
    }
    class func getLrcModelS(_ lrcname:String?) -> [KKLrcModel]{
        if lrcname == nil {
            return [KKLrcModel]()
        }
        guard let lrcPath = Bundle.main.path(forResource: lrcname, ofType: nil) else { return [KKLrcModel]() }
        var lrcContent = ""
        do {
           lrcContent = try String(contentsOfFile: lrcPath)
        } catch  {
            print("get LrcModels wrong")
            return [KKLrcModel]()
        }
        let timeArray = lrcContent.components(separatedBy: "\n")
        var lrcMs = [KKLrcModel]()
        for timeStr in timeArray {
            let resultLrcStr = timeStr.replacingOccurrences(of: "[", with: "")
            let timeAndContent = resultLrcStr.components(separatedBy: "]")
            if timeAndContent.count != 2 {
                continue
            }
            let time = timeAndContent[0]
            let content = timeAndContent[1]
            let lrcM = KKLrcModel()
            lrcM.beginTime = KKTimeTool.getTimeWithString(time)
            lrcM.lrcContent = content
            lrcMs.append(lrcM)
        }
        for i in 0..<lrcMs.count {
            if i == lrcMs.count - 1 {break}
            lrcMs[i].endTime = lrcMs[i+1].beginTime
        }
        return lrcMs
    }
    class func getCurrentLrcM(_ currentTime:TimeInterval,lrcMs:[KKLrcModel]) -> (row:Int,lrcM:KKLrcModel?){
        for i in 0..<lrcMs.count {
            let model = lrcMs[i]
            if currentTime >= model.beginTime && currentTime < model.endTime{
                return (i,model)
            }
        }
        return (0,nil)
    }
    
}
