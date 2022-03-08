//
//  SavedViewModel.swift
//  Shorts
//
//  Created by Rohit Saini on 07/03/22.
//

import Foundation


protocol SavedDelegate:CDMovieDelegate{
    var savedMovies: [Movie] { set get }
    func fetchSavedMovies()
    var onFetchMovieSucceed: (() -> Void)? { set get }
}

extension SavedDelegate{
    func fetchSavedMovies(){}
}

final class SavedMoviesViewModel: SavedDelegate{
    var onFetchMovieSucceed: (() -> Void)?
    var savedMovies: [Movie] = []
    
    func fetchSavedMovies(){
        if let movies = self.getAllMovies(){
            savedMovies = movies
            onFetchMovieSucceed?()
        }
    }
}
