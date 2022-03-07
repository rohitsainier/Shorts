//
//  MovieCellViewModel.swift
//  Shorts
//
//  Created by Rohit Saini on 06/03/22.
//

import Foundation

protocol MovieViewDelegate {
    var movie: Movie { set get }
    
}

final class MovieViewModel: MovieViewDelegate {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
