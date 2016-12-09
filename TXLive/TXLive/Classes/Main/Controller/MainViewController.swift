//
//  MainViewController.swift
//  TXLive
//
//  Created by LTX on 2016/12/9.
//  Copyright © 2016年 LTX. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加自控制器
        addChildViewControllerWithName(name: "Home")
        addChildViewControllerWithName(name: "Live")
        addChildViewControllerWithName(name: "Follow")
        addChildViewControllerWithName(name: "Profile")
        

    }

    private  func addChildViewControllerWithName(name : String) {
        
        //通过storyboard创建控制器
        let childViewController = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childViewController)
        
    }
    

}
