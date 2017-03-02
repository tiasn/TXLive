//
//  AnchorGroup.swift
//  TXLive
//
//  Created by LTX on 2017/3/1.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    //所有的房间
    var room_list : [[String : NSObject]]? {
    
        didSet {
            guard let  room_list = room_list else { return }
            
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    //组名称
    var tag_name : String = ""
    //组图标
    var icon_name : String = "home_header_normal"
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
