//
//  MovieCellViewModel.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit

class MovieCellViewModel {

    var movieModel:MovieModel
    var name:String{
        return movieModel.title ?? ""
    }
    var posterImage:String{
        return image_url_path + (movieModel.posterPath ?? "")
    }
    var id:Int{
        return movieModel.id!
    }
    var overView:String{
        return movieModel.overview ?? ""
    }
    var releaseDate:String{
        return movieModel.releaseDate ?? ""
    }
    init(movieModel:MovieModel) {
        self.movieModel = movieModel
    }
}
