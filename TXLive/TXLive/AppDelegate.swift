//
//  AppDelegate.swift
//  TXLive
//
//  Created by LTX on 2016/12/8.
//  Copyright © 2016年 LTX. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // 全局修改TabbartintColor
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }




}

