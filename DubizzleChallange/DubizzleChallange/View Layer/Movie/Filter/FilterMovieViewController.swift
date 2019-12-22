//
//  FilterMovieViewController.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/22/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit
import RxSwift
class FilterMovieViewController: BaseViewController {
    @IBOutlet weak var minYear: UITextField!
    
    @IBOutlet weak var maxYear: UITextField!
    var viewModel:FilterMovieViewModel!
    override var baseViewModel: BaseViewModel!{
        didSet{
            viewModel = baseViewModel as? FilterMovieViewModel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
    }

    override func configureBindings(){
        super.configureBindings()

        self.viewModel.popUpSubmitSubject.asObserver().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                self?.viewModel.validate(minYear: self?.minYear.text ?? "", maxYear: self?.maxYear.text ?? "")
                self?.viewModel.dismissViewControllerSubject.onNext((true,nil))
            })
            .disposed(by: bag)
    }

}
