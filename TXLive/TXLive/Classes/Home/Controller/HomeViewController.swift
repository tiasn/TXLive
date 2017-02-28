//
//  HomeViewController.swift
//  TXLive
//
//  Created by LTX on 2016/12/9.
//  Copyright © 2016年 LTX. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    // MARK:- 懒加载属性 PageTitleView
    fileprivate lazy var pageTitleView : PageTitleView = { [weak self] in
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        
        return titleView
        
    }()
    
    // MARK:- 懒加载属性 PageContentview
    fileprivate lazy var pageContentView : PageContentview = { [weak self] in
    
        //设置Frame
        let topH = kStatusBarH + kNavgationBarH + kTitleViewH + kTabbarH
        let contentH = kScreenH - topH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //设置childVc
        var childVcs = [UIViewController]()
            //推荐
        childVcs.append(RecommendViewController())
        
        for _ in 0..<3 {
            
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVcs.append(vc)
            
        }
        
        
        let pageContentView = PageContentview(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
        
    }()
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }


}


// MARK:- 设置界面
extension HomeViewController{
    //设置UI
   fileprivate func setUpUI() {
    
        //不需要自动调整UIScollView的内边距
        automaticallyAdjustsScrollViewInsets = false
    
        //设置导航栏
        setNavigationBar()
    
        //添加TitleView
        view.addSubview(pageTitleView)
    
        //添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.yellow
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


// MARK:- TitleView代理
extension HomeViewController : pageTitleViewDelegate{
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {

        pageContentView.setCurrentIndex(index: index)
        
    }

}


// MARK:- ContentView代理
extension HomeViewController : pageContentViewDelegate{
    func pageContentView(contentView: PageContentview, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}




