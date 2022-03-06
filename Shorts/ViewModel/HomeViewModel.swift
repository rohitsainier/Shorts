//
//  HomeViewModel.swift
//  Shorts
//
//  Created by Rohit Saini on 05/03/22.
//

import Foundation

enum MovieType{
    case Trending
    case NowPlaying
}

protocol MovieListDelegate: AnyObject {
    var trendingMovies: MovieModel? { set get }
    var nowPlayingMovies: MovieModel? { set get }
    var movieType: MovieType {set get}
    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }
    func fetchMovie(type: MovieType)
    func setMovieType(type: MovieType)
    func fetchNextBadge(type: MovieType,page: Int)
}

final class HomeViewModel: MovieListDelegate {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    var trendingMovies: MovieModel?
    var nowPlayingMovies: MovieModel?
    var movieType: MovieType = .Trending
    var onFetchMovieSucceed: (() -> Void)?
    var onFetchMovieFailure: ((Error) -> Void)?
    
    func fetchMovie(type: MovieType) {
        switch type {
            case .Trending:
                let request = TrendingMovieRequest()
                networkService.request(request) { [weak self] result in
                    switch result {
                        case .success(let movies):
                            self?.trendingMovies = movies
                            self?.onFetchMovieSucceed?()
                        case .failure(let error):
                            self?.onFetchMovieFailure?(error)
                    }
                }
            case .NowPlaying:
                let request = NowPlayingMovieRequest()
                networkService.request(request) { [weak self] result in
                    switch result {
                        case .success(let movies):
                            self?.nowPlayingMovies = movies
                            self?.onFetchMovieSucceed?()
                        case .failure(let error):
                            self?.onFetchMovieFailure?(error)
                    }
                }
        }
    }
    func setMovieType(type: MovieType) {
        movieType = type
        onFetchMovieSucceed?()
    }
    
    func fetchNextBadge(type:MovieType,page: Int) {
        switch type {
            case .Trending:
                let request = TrendingMovieRequest(page: page)
                networkService.request(request) { [weak self] result in
                    switch result {
                        case .success(let movies):
                            self?.trendingMovies?.page = movies.page
                            self?.trendingMovies?.results += movies.results
                            self?.onFetchMovieSucceed?()
                        case .failure(let error):
                            self?.onFetchMovieFailure?(error)
                    }
                }
            case .NowPlaying:
                let request = NowPlayingMovieRequest(page: page)
                networkService.request(request) { [weak self] result in
                    switch result {
                        case .success(let movies):
                            self?.nowPlayingMovies?.page = movies.page
                            self?.nowPlayingMovies?.results += movies.results
                            self?.onFetchMovieSucceed?()
                        case .failure(let error):
                            self?.onFetchMovieFailure?(error)
                    }
                }


        }

    }
}
