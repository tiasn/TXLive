//
//  NSDate-Extension.swift
//  TXLive
//
//  Created by LTX on 2017/3/1.
//  Copyright © 2017年 LTX. All rights reserved.
//

import Foundation

extension NSDate {
    
    //返回当前时间戳
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        let interver = Int(nowDate.timeIntervalSince1970)
        
        return "\(interver)"
        
    }
    
}
