//
//  Movie.swift
//  Shorts
//
//  Created by Rohit Saini on 05/03/22.
//

import Foundation


// MARK: - Welcome
struct MovieModel: Codable {
    let page: Int
    let results: [Movie]
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
   
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case id
    }
}

