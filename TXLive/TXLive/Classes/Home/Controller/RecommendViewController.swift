//
//  RecommendViewController.swift
//  TXLive
//
//  Created by LTX on 2017/2/28.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW = (kScreenW - 3 * kItemMargin) / 2
fileprivate let kNormalItemH = kItemW * 3 / 4
fileprivate let kPrettyItemH = kItemW * 4 / 3

fileprivate let kHeaderH : CGFloat = 50

fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"

fileprivate let kHederViewID = "kHederViewID"


class RecommendViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 布局
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        //注册CELL
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        //注册header
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHederViewID)

        return collectionView
    }()
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    


}


// MARK:- 设置UI
extension RecommendViewController {
    
  fileprivate  func setupUI()  {

        view.addSubview(collectionView)
    }
    
}

// MARK:- UICollectionView数据源、代理方法
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    //item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if section == 0 {
            return 8
        }
        
        return 4
        
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        
        return cell
        
    }
    
    // MARK:- 自定义sectionHeader
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHederViewID, for: indexPath)
        
        
        return headerView
        
        
    }
    
    
    
    
    // MARK:- 每个item的高度 宽度
    func collectionView(_ collectionView: UICollectionView,  layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // your code here
    
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)

        
    }
    
    
}





