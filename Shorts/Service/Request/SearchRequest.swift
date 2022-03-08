//
//  SearchRequest.swift
//  Shorts
//
//  Created by Rohit Saini on 08/03/22.
//

import Foundation

struct SearchMovieRequest: DataRequest {
    typealias Response = MovieModel
    var page: Int
    var query: String
    private let apiKey: String = "4f5c62f312dd179fa66327da5db9e5f3"
    
    init(page: Int = 1, query: String = ""){
        self.page = page
        self.query = query
    }
    var url: String {
        let baseURL: String = "https://api.themoviedb.org/3"
        let path: String = "/search/movie"
        return baseURL + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "api_key": apiKey,
            "query": query,
            "page": "\(page)"
        ]
    }
    
    var method: HTTPMethod {
        .GET
    }
}
