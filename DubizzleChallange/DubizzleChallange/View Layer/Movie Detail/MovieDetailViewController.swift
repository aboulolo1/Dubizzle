//
//  MovieDetailViewController.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/22/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit
import SDWebImage
class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieBoster: UIImageView!
    
    var viewModel:MovieDetailViewModel!
    override var baseViewModel: BaseViewModel!{
        didSet{
            viewModel = baseViewModel as? MovieDetailViewModel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
   private func configureUi() {
        self.movieName.text = viewModel.movieCellViewModel.name
        self.movieBoster.sd_setImage(with: URL(string: viewModel.movieCellViewModel.posterImage), completed: nil)
        self.movieOverView.text = viewModel.movieCellViewModel.overView
    self.movieReleaseDate.text = "Release Date : " + viewModel.movieCellViewModel.releaseDate

    }

}
