//
//  MovieViewModel.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//

import UIKit
import RxSwift

enum MoiveType{
    case discoverMovie(minYear:String,maxYear:String)
    case allMovie
}
class MovieViewModel: BaseViewModel {

  override var viewIdentifier: ViewIdentifier!{
        get{
            return ViewIdentifier(storyboardIdentifier: "Main", ViewControllerIdentifier: "MovieViewControllerNav")
        }
        set{}
    }
    let movieNetwork = MovieManger()
    
    var page:Int = 1
    
    var movieList:[MovieCellViewModel] = []
    var dataSource:PublishSubject<[MovieCellViewModel]> = PublishSubject()
    var movieType:MoiveType = .allMovie
    
    func configureDate(_ loadingType:LoadingType)  {
        print(page)
        switch movieType {
        case .allMovie:
            getAllMovie(loadingType: loadingType)
        case .discoverMovie(let minYear,let maxYear):
            discoverMovie(loadingType: loadingType, minYear: minYear, maxYear: maxYear)
            
        }
        
    }
    private func discoverMovie(loadingType:LoadingType,minYear:String,maxYear:String){
        self.showLoadingSubject.onNext(loadingType)
        movieNetwork.getMovie(by: page, minYear: minYear, maxYear: maxYear) {  [weak self](result) in
            self?.hideLoadingSubject.onNext(loadingType)
            switch result{
            case .failure(let err):
                self?.showAlertErrorSubject.onNext(err.localizedDescritpion)
            case .success(let response):
                self?.configureDataSource(loadingType: loadingType, movieList: response.results ?? [])
            }
        }
    }
    private func getAllMovie(loadingType:LoadingType){
        self.showLoadingSubject.onNext(loadingType)
        movieNetwork.getMovie(by: page) { [weak self](result) in
            self?.hideLoadingSubject.onNext(loadingType)
            switch result{
            case .failure(let err):
                self?.showAlertErrorSubject.onNext(err.localizedDescritpion)
            case .success(let response):
                self?.configureDataSource(loadingType: loadingType, movieList: response.results ?? [])
            }
        }
    }
    private func configureDataSource(loadingType:LoadingType,movieList:[MovieModel]){
        if movieList.count == 0{
            self.showAlertErrorSubject.onNext("No Data Found")
        }
        else{
            switch loadingType{
                case .Default:
                    self.movieList = movieList.map{MovieCellViewModel(movieModel: $0)}
                case .InfiniteScroll:
                
                    self.movieList.append(contentsOf: movieList.map{MovieCellViewModel(movieModel: $0)})
            default:break
            }
            dataSource.onNext(self.movieList)
        }
    }
}
