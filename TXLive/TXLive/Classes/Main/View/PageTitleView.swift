//
//  PageTitleView.swift
//  TXLive
//
//  Created by LTX on 2016/12/11.
//  Copyright © 2016年 LTX. All rights reserved.
//

import UIKit

//代理的协议
protocol pageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

fileprivate let kScrollLineH : CGFloat = 2
fileprivate let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85,85)
fileprivate let kSelectorColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageTitleView: UIView {

    //自定义属性：标题数组
    fileprivate var titles : [String]
    fileprivate var currentIndex = 0;
    weak var delegate : pageTitleViewDelegate?
    
    
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
            lable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.textAlignment = .center
            
            //设置labe的Frame
            let labelX : CGFloat  = lableW * CGFloat(index)
            lable.frame = CGRect(x: labelX, y: lableY, width: lableW, height: lableH)

            // 添加点击事件
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLableClick(_ :)))
            lable.addGestureRecognizer(tapGes)
            
            
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
        
        firstLable.textColor = UIColor(r: kSelectorColor.0, g: kSelectorColor.1, b: kSelectorColor.2)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - kScrollLineH, width: firstLable.frame.size.width, height: kScrollLineH)
        
    }
}


// MARK:- 监听事件
extension PageTitleView{

    @objc fileprivate func titleLableClick(_ tapGes : UIGestureRecognizer){
       
        //点击的lable
        guard let currentLable = tapGes.view as? UILabel else {
            return
        }
        
        if currentIndex == currentLable.tag {
            return
        }

        // 旧的lable
        let oldLable = titleLables[currentIndex]
        
        
        // 修改颜色
        currentLable.textColor = UIColor(r: kSelectorColor.0, g: kSelectorColor.1, b: kSelectorColor.2)
        oldLable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        let scrollLineX = CGFloat(currentLable.tag) * scrollLine.frame.width
        UIView .animate(withDuration: 0.25) {
            
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        
        //保存最新的lable下标
        currentIndex = currentLable.tag
        
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }

}


// MARK:- 对外暴露的方法
extension PageTitleView {
    
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        //取出lable
        let sourceLable = titleLables[sourceIndex]
        let targetLable = titleLables[targetIndex]
        
        let moveTotal = targetLable.frame.origin.x - sourceLable.frame.origin.x
        let moveX = moveTotal * progress
        
        //指示线联动
        scrollLine.frame.origin.x = sourceLable.frame.origin.x + moveX
        
        
        //颜色渐变
        //取出渐变范围
        let colorDelta = (kSelectorColor.0 - kNormalColor.0, kSelectorColor.1 - kNormalColor.1, kSelectorColor.2 - kNormalColor.2)
        
        //sourceLabel变色
        sourceLable.textColor = UIColor(r: kSelectorColor.0 - colorDelta.0 * progress, g: kSelectorColor.1 - colorDelta.1 * progress, b: kSelectorColor.2 - colorDelta.2 * progress)
        
        //targetLable变色
        targetLable.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1*progress, b: kNormalColor.2 + colorDelta.2*progress)
        
        //保存最新的index
        currentIndex = targetIndex
        
    }
    
}




