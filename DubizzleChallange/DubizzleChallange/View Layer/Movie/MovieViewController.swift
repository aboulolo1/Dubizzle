//
//  MovieViewController.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/22/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import SDWebImage

class MovieViewController: BaseViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var viewModel:MovieViewModel!
    override var baseViewModel: BaseViewModel!{
        didSet{
            viewModel = baseViewModel as? MovieViewModel
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBindings()
        viewModel.configureDate(.Default)
    }
    
    override func configureBindings(){
        super.configureBindings()
        viewModel.dataSource.asObservable().observeOn(MainScheduler.instance).bind(to: movieCollectionView.rx.items(cellIdentifier: "movieCell", cellType: MovieCollectionViewCell.self)) { [weak self](row, element, cell) in
            cell.cellViewModel = self?.viewModel.movieList[row]
            cell.updateView()
        }.disposed(by: bag)
        
        movieCollectionView.rx.itemSelected.subscribe(onNext:{ indexPath in
                self.viewModel.pushViewControllerSubject.onNext(MovieDetailViewModel(movieCellViewModel: self.viewModel.movieList[indexPath.row]))
            }).disposed(by: bag)
        
        
    }
    private func configureUI(){
        movieCollectionView.infiniteScrollIndicatorStyle = .white
        movieCollectionView.addInfiniteScroll { (collectionView) -> Void in
            collectionView.performBatchUpdates({ [weak self]() -> Void in
                self?.viewModel.page += 1
                self?.viewModel.configureDate(.InfiniteScroll)
            }, completion: { (finished) -> Void in
                // finish infinite scroll animations
                collectionView.finishInfiniteScroll()
            });
        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: CollectionViewItem.spacing, left: CollectionViewItem.spacing, bottom: CollectionViewItem.spacing, right: CollectionViewItem.spacing)
        layout.itemSize = CGSize(width: CollectionViewItem.width, height: CollectionViewItem.height)
        layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0
        movieCollectionView!.collectionViewLayout = layout
    }
    
    @IBAction func filterAction(_ sender: Any) {
        let filterMovieViewModel = FilterMovieViewModel()
        filterMovieViewModel.dataSource.asObserver().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self](filterItem) in
               self?.viewModel.page = 1
                self?.viewModel.movieType = .discoverMovie(minYear: filterItem.minYear, maxYear: filterItem.maxYear)
                self?.viewModel.configureDate(.Default)
            })
            .disposed(by: bag)
        self.viewModel.popUpViewControllerSubject.onNext(filterMovieViewModel)
    }
}
