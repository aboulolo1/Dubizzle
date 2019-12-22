//
//  MovieRouter.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import Foundation


enum MovieEndPoint {
    case allMovies(page:Int)
    case discoverMovie(page:Int,minYear:String,maxYear:String)
}

struct MovieRouter:Router {
    
    var endPoint:MovieEndPoint
    var path: String{
        switch endPoint {
        case .allMovies:
            return "/3/discover/movie"
        case .discoverMovie:
            return "/3/discover/movie"
        }
    }
    
    var method: HttpMethod{
        switch endPoint {
              case .allMovies,.discoverMovie:
                return .get
            
              }
    }
    var parameter: httpParameters?{
        switch endPoint {
        case .allMovies(let page):
            var mutableParamter = baseParameter
            mutableParamter?["page"] = "\(page)"
            return mutableParamter
        case .discoverMovie(let page,let minYear,let maxYear):
            var mutableParamter = baseParameter
            mutableParamter?["page"] = "\(page)"
            mutableParamter?["primary_release_date.gte"] = minYear
            mutableParamter?["primary_release_date.lte"] = maxYear

            return mutableParamter

        }
    }
   
    
}
