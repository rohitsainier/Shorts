//
//  SearchViewModel.swift
//  Shorts
//
//  Created by Rohit Saini on 08/03/22.
//

import Foundation

protocol SearchDelegate{
    var workItemReferance: DispatchWorkItem? { get set }
    var searchedMovies: MovieModel? { set get }
    func searchMovies(query: String)
    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }
}

final class SearchViewModel: SearchDelegate{
    var workItemReferance: DispatchWorkItem?
    var searchedMovies: MovieModel?
    var onFetchMovieSucceed: (() -> Void)?
    var onFetchMovieFailure: ((Error) -> Void)?
    
    private let networkService: NetworkService
    
    
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    
    func searchMovies(query: String = "") {
        workItemReferance?.cancel()
        let workItem = DispatchWorkItem {
            let request = SearchMovieRequest(query: query)
            self.networkService.request(request) { [weak self] result in
                switch result {
                    case .success(let movies):
                        self?.searchedMovies = movies
                        self?.onFetchMovieSucceed?()
                    case .failure(let error):
                        self?.searchedMovies = nil
                        self?.onFetchMovieFailure?(error)
                }
            }
        }
        workItemReferance = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
    }
}
