//
//  NetworkRouter.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import Foundation

protocol NetworkMangerProtocol {
     associatedtype T
    typealias netWorkRouterCompletion = (Result<T,ApiError>)-> Void
    func performNetworRequest(_ request:Router , completion:@escaping netWorkRouterCompletion)
}
