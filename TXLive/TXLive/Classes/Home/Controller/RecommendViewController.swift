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
    
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
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
        
        // UI设置
        setupUI()
        
        //获取数据
        loadData()
        
    }
    

}


// MARK:- 设置UI
extension RecommendViewController {
    
  fileprivate  func setupUI()  {

        view.addSubview(collectionView)
    }
    
}

// MARK:- 请求数据
extension RecommendViewController {
    
    fileprivate func loadData(){
        
        recommendVM.requestData { 
            
            self.collectionView.reloadData()
            
        }
    }
}



// MARK:- UICollectionView数据源、代理方法
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.AnchorGroups.count
    }
    
    //item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        let group = recommendVM.AnchorGroups[section]
        return group.anchors.count
        
        
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //取出模型
        let group = recommendVM.AnchorGroups[indexPath.section]
        let anchor  = group.anchors[indexPath.item]
        
        
        if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            cell.anchor = anchor
            return cell
            
        }else{
          let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
            cell.anchor = anchor
            return cell
        }
        
        

        
    }
    
    // MARK:- 自定义sectionHeader
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHederViewID, for: indexPath) as! CollectionHeaderView
        
       headerView.group = recommendVM.AnchorGroups[indexPath.section]
                
        return headerView
        
        
    }
    
    
    
    
    // MARK:- 每个item的高度 宽度
    func collectionView(_ collectionView: UICollectionView,  layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)

        
    }
    
    
}





