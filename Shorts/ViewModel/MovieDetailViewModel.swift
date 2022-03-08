//
//  MovieDetailViewModel.swift
//  Shorts
//
//  Created by Rohit Saini on 07/03/22.
//

import Foundation
import UIKit

protocol MovieDetailDelegate:NaviagtionDelegate,CDMovieDelegate{
    func addToBookmark(movie: Movie)
    func isSaved(movie: Movie) -> Bool
    var onAddToBookmarkMovieSucceed: (() -> Void)? { set get }
    var onBookmarkFailure: ((Error) -> Void)? { set get }
    
}


final class MovieDetailViewModel:MovieDetailDelegate{
    
    var onAddToBookmarkMovieSucceed: (() -> Void)?
    var onBookmarkFailure: ((Error) -> Void)?
    
    func addToBookmark(movie: Movie) {
        self.create(movie: movie)
        onAddToBookmarkMovieSucceed?()
    }
    
    func isSaved(movie: Movie) -> Bool{
        let saved = self.get(byIdentifier: String(movie.id))
        return (saved != nil) ? true : false
    }
    
}
