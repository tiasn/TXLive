//
//  CollectionNormalCell.swift
//  TXLive
//
//  Created by LTX on 2017/2/28.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var nikeName: UILabel!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var roomName: UILabel!
    
    
    
    //自定义模型属性
    var anchor : AnchorModel?{
        didSet{
            
            guard let anchor = anchor else {
                return
            }
            
            nikeName.text = anchor.nickname
            
            //取出在线人数
            var onlineStr : String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            roomName.text = anchor.room_name
            
            let url = NSURL(string : anchor.vertical_src)            
            iconImage.kf.setImage(with: url?.absoluteURL)
        
        }
    }
    

}
