//
//  Movie.swift
//  Shorts
//
//  Created by Rohit Saini on 05/03/22.
//

import Foundation
import UIKit


// MARK: - Welcome
struct MovieModel: Codable {
    var page: Int
    var results: [Movie]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let originalTitle: String?
    let posterPath: String
    let overview: String
    let releaseDate: String?
    let id: Int
    let movieImageData: Data?
    public var posterURL: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
   
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case id
        case movieImageData
    }
}

// MARK: - SavedMovie
struct SavedMovie: Codable {
    let originalTitle: String?
    let overview: String
    let id: Double
    let posterURL: Data
}
