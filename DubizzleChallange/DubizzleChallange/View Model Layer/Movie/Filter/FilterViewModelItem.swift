//
//  FilterViewModelItem.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/22/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit

class FilterViewModelItem {

    var minYear:String
    var maxYear:String
    
    init(minYear:String,maxYear:String) {
        if minYear == ""{
            self.minYear = ""
        }
        else{
            self.minYear = "\(minYear)-01-01"
        }
        if maxYear == ""{
            self.maxYear = ""
        }
        else{
            self.maxYear = "\(maxYear)-01-01"
        }
    }
}
