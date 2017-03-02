//
//  AnchorModel.swift
//  TXLive
//
//  Created by LTX on 2017/3/1.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    // 房间号
    var room_id : Int = 0
    // 房间封面图
    var vertical_src : String = ""
    //直播类型 0：电脑 1：手机
    var isVertical : Int = 0
    
    //房间名称
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //观看人数
    var online : Int = 0
    
    //城市
    var anchor_city : String = ""
    
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {  }
    
    
}
