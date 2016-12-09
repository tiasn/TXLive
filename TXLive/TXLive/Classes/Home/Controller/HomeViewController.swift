//
//  HomeViewController.swift
//  TXLive
//
//  Created by LTX on 2016/12/9.
//  Copyright © 2016年 LTX. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }


}


// MARK:- 设置界面
extension HomeViewController{
    //设置UI
   fileprivate func setUpUI() {
        setNavigationBar()
    }
    
    //设置导航栏
    fileprivate func setNavigationBar(){
    
        // 1.设置左导航栏
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "logo")
    
        // 2.设置右导航栏
        let btnSize = CGSize(width: 40, height: 40)
        
        // 浏览记录
//        let historyItem = UIBarButtonItem.txItem(image: "image_my_history", highImage: "Image_my_history_click", size: btnSize)
        //搜索
//        let searchItem = UIBarButtonItem.txItem(image: "btn_search", highImage: "btn_search_clicked", size: btnSize)
//        //扫码
//        let qrcodeItem = UIBarButtonItem.txItem(image: "Image_scan", highImage: "Image_scan_click", size: btnSize)
        
        let historyItem = UIBarButtonItem(image: "image_my_history", highImage: "Image_my_history_click", size: btnSize)
        let searchItem = UIBarButtonItem(image: "btn_search", highImage: "btn_search_clicked", size: btnSize)
        let qrcodeItem = UIBarButtonItem(image: "Image_scan", highImage: "Image_scan_click", size: btnSize)
                
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    
    
}
