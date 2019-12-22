//
//  BaseViewModel.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import RxSwift

struct ViewIdentifier{
    var storyboardIdentifier:String!
    var ViewControllerIdentifier:String!
}

class BaseViewModel: NSObject {
    
    let bag = DisposeBag()
    
    let pushViewControllerSubject = PublishSubject<BaseViewModel>()
    let presentViewControllerSubject = PublishSubject<BaseViewModel>()
    let dismissViewControllerSubject = PublishSubject<(animated: Bool, complition: (() -> Void)?)>()
    let popToRootViewControllerSubject = PublishSubject<Bool>()
    let popViewControllerSubject = PublishSubject<Bool>()
    let showAlertErrorSubject = PublishSubject<String>()
    let popUpViewControllerSubject = PublishSubject<BaseViewModel>()
    let popUpSubmitSubject = PublishSubject<Bool>()

    let showLoadingSubject = PublishSubject<LoadingType>()
    let hideLoadingSubject = PublishSubject<LoadingType>()

    
    var viewIdentifier:ViewIdentifier!
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}



