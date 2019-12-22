//
//  ApiConfiguration.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//
import Foundation


enum HttpMethod : String {
    case get = "Get"
    case post = "Post"
}

enum EnviromentType{
    case production
    case staging
    
    var baseUrl:String{
        switch self {
        case .production:
            return "api.themoviedb.org"
        case .staging:
            return "api.themoviedb.org"
        }
    }
}

typealias httpHeaders = [String:String]
typealias httpParameters = [String:String]

protocol Router {
    var path:String{get}
    var baseUrl:String{get}
    var scheme:String{get}
    var method:HttpMethod { get }
    var headers:httpHeaders? { get }
    var baseParameter:httpParameters? { get}
    var parameter:httpParameters? { get}
    var body:httpParameters? { get }
}
extension Router{
    var headers:httpHeaders?{
        return ["content-type":"application/json","Accept":"application/json"]
    }
    var baseParameter:httpParameters?{
        get{
            return ["api_key":"47cd13548fd27bb3d1b4d9a59c3bb745","language":"en-US"]
        }
    }
    var baseUrl:String{
        let enviromentType:EnviromentType = .staging
        return enviromentType.baseUrl
    }
    
    var body:httpParameters?{
        return nil
    }
    
    var scheme:String{
           return "https"
       }
}
