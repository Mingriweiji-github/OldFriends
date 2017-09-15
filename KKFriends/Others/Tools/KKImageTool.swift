//
//  KKImageTool.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/15.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKImageTool: NSObject {

    class func getNewImage(_ sourceImage:UIImage?,str:String?) -> UIImage?{
        guard let image = sourceImage else { return nil }
        guard let resultStr = str else { return image }
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let textRext = CGRect(x: 0, y: 0, width: image.size.width, height: 20)
        let textAttributte = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName:UIFont.systemFont(ofSize: 18),
            NSParagraphStyleAttributeName:style
        ]
        
        (resultStr as NSString).draw(in: textRext, withAttributes: textAttributte)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
