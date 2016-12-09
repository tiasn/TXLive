//
//  UIBarButtonItem-Extension.swift
//  TXLive
//
//  Created by LTX on 2016/12/9.
//  Copyright © 2016年 LTX. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /*
    class func txItem(image : String, highImage : String, size : CGSize) -> UIBarButtonItem {
        
        let cusBtn = UIButton()
        cusBtn.setImage(UIImage(named : image), for: .normal)
        cusBtn.setImage(UIImage(named : highImage), for: .highlighted)
        cusBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        let txBarButtonItem = UIBarButtonItem(customView: cusBtn)
        
        return txBarButtonItem
        
    }
 
    */
    
    
    // convenience构造函数   必须调用设计函数    self.init(customView : cusBtn)
    convenience init(image : String, highImage : String = "", size : CGSize = CGSize.zero) {
        
        let cusBtn = UIButton()
        cusBtn.setImage(UIImage(named : image), for: .normal)
        if highImage != "" {
            cusBtn.setImage(UIImage(named : highImage), for: .highlighted)
        }
        
        if size == CGSize.zero {
            
            cusBtn.sizeToFit()
            
        }else{
            
        cusBtn.frame = CGRect(origin: CGPoint.zero, size: size)
       
        }
        
        self.init(customView : cusBtn)
        
    }
    
    
    
}
