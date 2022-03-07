//
//  MovieDetailViewModel.swift
//  Shorts
//
//  Created by Rohit Saini on 07/03/22.
//

import Foundation
import UIKit

protocol MovieDetailDelegate:NaviagtionDelegate{
    func addToBookmark(movie: Movie)
    var onAddToBookmarkMovieSucceed: (() -> Void)? { set get }
    var onBookmarkFailure: ((Error) -> Void)? { set get }
    
}


final class MovieDetailViewModel:MovieDetailDelegate{
    var onAddToBookmarkMovieSucceed: (() -> Void)?
    var onBookmarkFailure: ((Error) -> Void)?
    
    func addToBookmark(movie: Movie) {
        //add to core data db
        onAddToBookmarkMovieSucceed?()
    }
}
