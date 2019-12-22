//
//  MovieCollectionViewCell.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/22/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var cellViewModel:MovieCellViewModel!{
        didSet{
            updateView()
        }
    }
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    func updateView() {
        movieName.text = cellViewModel.name
        movieImage.sd_setImage(with: URL(string: cellViewModel.posterImage), completed: nil)
    }
}
