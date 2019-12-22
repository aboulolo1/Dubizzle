//
//  ApiError.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit

enum ApiError:Error {
    case noData
    case invalidData
    case noConnetion
    case noDataCached
    case serviceUnAvailable
    case error(String)
}
extension ApiError
{
    var localizedDescritpion:String{
        switch self {
        case .noData:
            return "No Data Found"
        case .invalidData:
            return "Invaild Data"
        case .noConnetion:
            return "No Internet Connection"
        case .error(let err):
            return err
        case .noDataCached:
            return "No Data Cached"
        case .serviceUnAvailable:
            return "Service not Available"

        }
    }
}
