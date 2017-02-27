//
//  PageContentview.swift
//  TXLive
//
//  Created by LTX on 2016/12/12.
//  Copyright © 2016年 LTX. All rights reserved.
//

import UIKit

//代理协议
protocol pageContentViewDelegate : class {
    
    func pageContentView(contentView : PageContentview, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}


private let ContentCellID = "ContentCellID"

class PageContentview: UIView {
    
    //定义属性 子控制器数组
    fileprivate var childVcs : [UIViewController]
    // 属性 父控制器
    fileprivate weak var parentViewController : UIViewController?
    
    fileprivate var startOffsetX : CGFloat = 0
    
    fileprivate var isForbidScrollViewDelegate : Bool = false
    
    weak var delegate : pageContentViewDelegate?
    
    //创建collectionView
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView;
    
    }()

    
    //自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
    
        //设置UI
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

 // MARK:- 设置UI
extension PageContentview {
    
  fileprivate  func setupUI() {
        // 添加所有子控制器到父控制器
    for childVc in childVcs {
        parentViewController?.addChildViewController(childVc)
    }
    
        //添加collectionView
    addSubview(collectionView)
    collectionView.frame = bounds
        
    }
}

// MARK:- collectionView数据源方法
extension PageContentview : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //创建cell
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //给cell添加内容
        
        for view in cell.contentView.subviews {
            view .removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)

        return cell
    
        
    }
    


}



// MARK:- collectionView代理方法
extension PageContentview : UICollectionViewDelegate {
    
    //即将滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollViewDelegate = false

        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        //如果是点击事件 拦截
        if isForbidScrollViewDelegate  {return}
        
        //滑动
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        
        if currentOffsetX > startOffsetX {//左划
            
            //计算Progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //滑动停止 完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
                
            }
            
        }else{//右滑
        
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
            
        }
        
        print("progress:\(progress)   targetIndex: \(targetIndex)   sourceIndex : \(sourceIndex)")
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
    }
    
}

// MARK:- 对外暴露的方法
extension PageContentview {
    
    func setCurrentIndex(index : Int) {
        
        isForbidScrollViewDelegate = true
        
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offsetX, y : 0), animated: false)
        
    }
    
}



