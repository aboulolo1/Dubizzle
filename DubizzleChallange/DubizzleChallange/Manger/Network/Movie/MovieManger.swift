//
//  MovieManger.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//
import UIKit

class MovieManger:NetworkManger<BaseModel<MovieModel>> {
    
    typealias responseHandler = (Result<BaseModel<MovieModel>,ApiError>)->Void

    func getMovie(by page:Int,completion:@escaping responseHandler)  {
        
        let movieRouter = MovieRouter(endPoint: .allMovies(page: page))
        
        self.performNetworRequest(movieRouter) { (result) in
           completion(result)
        }
        
    }
    
    func getMovie(by page:Int,minYear:String,maxYear:String,completion:@escaping responseHandler)  {
        
        let movieRouter = MovieRouter(endPoint: .discoverMovie(page: page, minYear: minYear, maxYear: maxYear))
        
        self.performNetworRequest(movieRouter) { (result) in
            completion(result)
        }
        
    }
}
