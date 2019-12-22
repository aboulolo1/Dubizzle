//
//  FilterMovieViewModel.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/22/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit
import RxSwift
class FilterMovieViewModel: BaseViewModel {

    override var viewIdentifier: ViewIdentifier!{
        get{
            return ViewIdentifier(storyboardIdentifier: "Main", ViewControllerIdentifier: "FilterMovieViewController")
        }
        set{}
    }
    var dataSource:PublishSubject<FilterViewModelItem> = PublishSubject()

    func validate(minYear:String,maxYear:String){
      
            dataSource.onNext(FilterViewModelItem(minYear: minYear, maxYear: maxYear))
    }
    
}
