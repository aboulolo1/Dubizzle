//
//  BaseViewController.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit
import RxSwift
import SwiftMessageBar
import SVProgressHUD
import PopupDialog

class BaseViewController: UIViewController {

    var baseViewModel:BaseViewModel!
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func configureBindings() {
        
        baseViewModel.pushViewControllerSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (viewModel) in
                let viewController = BaseViewController.instantiateViewControllerFrom(viewModel: viewModel)
                if let navigationController =  self?.navigationController{
                    navigationController.pushViewController(viewController, animated: true)
                }
            })
            .disposed(by: bag)
        
        baseViewModel.presentViewControllerSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (viewModel) in
                let viewController = BaseViewController.instantiateViewControllerFrom(viewModel: viewModel)
                let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.isNavigationBarHidden = true
                self?.present(navigationController, animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        baseViewModel.dismissViewControllerSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (animated, complition) in
                self?.dismiss(animated: animated, completion: complition)
            })
            .disposed(by: bag)
        
        baseViewModel.popToRootViewControllerSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (animated) in
                self?.navigationController?.popToRootViewController(animated: animated)
            })
            .disposed(by: bag)
        
        baseViewModel.popViewControllerSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (animated) in
                self?.navigationController?.popViewController(animated: animated)
            })
            .disposed(by: bag)
        
        baseViewModel.showLoadingSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { (loadingType) in
                if loadingType == .Default {
                    SVProgressHUD.show()
                }
            })
            .disposed(by: bag)
        
        baseViewModel.hideLoadingSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { (loadingType) in
                if loadingType == .Default {
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: bag)
        
        baseViewModel.popUpViewControllerSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (viewModel) in
                self?.showCustomDialog(viewModel: viewModel)
            })
            .disposed(by: bag)
        baseViewModel.showAlertErrorSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (err) in
                self?.showAlert(with: "Error", message: err, type: .error)
            })
            .disposed(by: bag)
    }

}
extension BaseViewController{
    
    static func instantiateViewControllerFrom(viewModel:BaseViewModel) -> BaseViewController{
        let storyboard = UIStoryboard(name: viewModel.viewIdentifier.storyboardIdentifier, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewModel.viewIdentifier.ViewControllerIdentifier) as! BaseViewController
        viewController.baseViewModel = viewModel
        return viewController
    }
    static func instantiateNavViewControllerFrom(viewModel:BaseViewModel) -> UINavigationController{
        let storyboard = UIStoryboard(name: viewModel.viewIdentifier.storyboardIdentifier, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: viewModel.viewIdentifier.ViewControllerIdentifier) as! UINavigationController
            (viewController.children.first as! BaseViewController).baseViewModel = viewModel
        return viewController
    }
     func showAlert(with title:String , message:String,type:MessageType) {
        SwiftMessageBar.showMessage(withTitle: title, message: message, type: type)

    }
    func showCustomDialog(animated: Bool = true , viewModel:BaseViewModel) {
        
        // Create a custom view controller
        let viewController = BaseViewController.instantiateViewControllerFrom(viewModel: viewModel)
        
        // Create the dialog
        let popup = PopupDialog(viewController: viewController,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: false,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "DONE", height: 60,dismissOnTap:false ) {
            viewModel.popUpSubmitSubject.onNext(true)
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
}
