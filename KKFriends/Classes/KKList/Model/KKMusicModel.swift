//
//  KKMusicModel.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKMusicModel: NSObject {
    var filename: String?
    var songname :String?
    var lrcname:String?
    var singername: String?
    var singerIcon:String?
    var icon:String?
    
    override init() {
        super.init()
    }
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
