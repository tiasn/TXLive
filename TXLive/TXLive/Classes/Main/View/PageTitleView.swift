//
//  PageTitleView.swift
//  TXLive
//
//  Created by LTX on 2016/12/11.
//  Copyright © 2016年 LTX. All rights reserved.
//

import UIKit

fileprivate let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    //自定义属性：标题数组
   fileprivate var titles : [String]
    
    // 懒加载属性
    fileprivate lazy var titleLables : [UILabel] = [UILabel]()
    
    // 懒加载属性
    fileprivate lazy var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
        
    }()
    
    // 懒加载属性
    fileprivate lazy var scrollLine : UIView = {
        
        let scrollLine  = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
        
    }()
    
    
    //自定义构造方法
    init(frame: CGRect, titles : [String]) {
     
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置UI界面
extension PageTitleView{
    
    fileprivate func setupUI() {
        // 添加ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加title Lable
        setupTitleLables()
        
        //添加TitleView底部滚动线
        setupBottomLineAndScrollLine()
    }
    
    
    fileprivate func setupTitleLables() {
        
        //labe的值
        let lableW : CGFloat = frame.width / CGFloat(titles.count)
        let lableH : CGFloat  = frame.height - kScrollLineH
        let lableY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            
            // 创建lable
            let lable = UILabel()
            
            //设置lable属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 15)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            
            //设置labe的Frame
            let labelX : CGFloat  = lableW * CGFloat(index)
            
            lable.frame = CGRect(x: labelX, y: lableY, width: lableW, height: lableH)
            
            //添加lable到ScrollView
            scrollView.addSubview(lable)
            
            //添加到数组
            titleLables.append(lable)
        }
        
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        // 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine
        guard let firstLable = titleLables.first else {
            return
        }
        
        firstLable.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - kScrollLineH, width: firstLable.frame.size.width, height: kScrollLineH)
        
    }
}




