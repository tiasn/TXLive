//
//  NetworkTools.swift
//  TXLive
//
//  Created by LTX on 2017/2/28.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    
    case GET
    case POST
}


class NetworkTools {

    class func requestData(type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping (_ result : Any) -> ()){
        
        //类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
           
            //获取结果
            guard let result = response.result.value else{
                print(response.result.error!)
                return
            }
            
            finishedCallBack(result)
            
        }
    }
    
}
