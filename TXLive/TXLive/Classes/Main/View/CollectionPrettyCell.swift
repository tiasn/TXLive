//
//  CollectionPrettyCell.swift
//  TXLive
//
//  Created by LTX on 2017/2/28.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var anchorName: UILabel!
    
    @IBOutlet weak var cityLable: UIButton!
    
    
    var anchor : AnchorModel? {
    
        didSet{
            
            guard let anchor = anchor else {
                return
            }
            
            //取出在线人数
            var onlineStr : String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //昵称
            anchorName.text = anchor.nickname
            
            //城市
            cityLable.setTitle(anchor.anchor_city, for: .normal)
        
            //设置封面
            let iconURL = NSURL(string: anchor.vertical_src)
            
            imageView.kf.setImage(with: iconURL?.absoluteURL)
            
        }
    }
    

}
