//
//  MovieDetailViewModel.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/22/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit

class MovieDetailViewModel:BaseViewModel {

    override var viewIdentifier: ViewIdentifier!{
        get{
            return ViewIdentifier(storyboardIdentifier: "Main", ViewControllerIdentifier: "MovieDetailViewController")
        }
        set{}
    }
    var movieCellViewModel:MovieCellViewModel
    init(movieCellViewModel:MovieCellViewModel) {
        self.movieCellViewModel = movieCellViewModel
    }
}
