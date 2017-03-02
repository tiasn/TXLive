//
//  RecommendViewModel.swift
//  TXLive
//
//  Created by LTX on 2017/3/1.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
     lazy var AnchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()

}

// MARK:- 发送网络请求
extension RecommendViewModel {

    func requestData(finishedCallBack : @escaping () -> ()) {
        
        //参数
        let parameters =  ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        //创建组
        let disGroup = DispatchGroup()
        
        //获取推荐数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //手动创建一个组
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            disGroup.leave()

        }
        
        
        //获取颜值主播数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String :NSObject] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            
            //手动创建一个组
            self.prettyGroup.tag_name = "颜值"
             self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
            
                let anchor = AnchorModel(dict: dict)
                
                 self.prettyGroup.anchors.append(anchor)
                
            }
            
            disGroup.leave()

            
        }
        

        
        // 获取游戏主播数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters) { (result) in
            
            //字典   [String : NSObject]
            //存放字典的数组 [[String : NSObject]]
            
            //转成字典
            guard let resultDict = result as?  [String : NSObject] else { return }
            
            //取出房间数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }

            //转成模型 保存到数组里
            for dic in dataArray {
                
                let group = AnchorGroup.init(dict: dic)
               self.AnchorGroups.append(group)
                
            }
            

            disGroup.leave()

        }
        
        
        //所有数据请求完毕 排序
        disGroup.notify(queue: DispatchQueue.main, execute: {
            
            self.AnchorGroups.insert(self.prettyGroup, at: 0)
            self.AnchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallBack()
            
        })

        
    }
    

}
