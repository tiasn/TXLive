//
//  CollectionHeaderView.swift
//  TXLive
//
//  Created by LTX on 2017/2/28.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    //属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    
    //自定义模型
    var  group : AnchorGroup? {
    
        didSet {
            titleLable.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
}
