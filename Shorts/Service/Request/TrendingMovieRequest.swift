//
//  MovieRequest.swift
//  Shorts
//
//  Created by Rohit Saini on 05/03/22.
//

import Foundation


struct TrendingMovieRequest: DataRequest {
    typealias Response = MovieModel
    var page: Int
    private let apiKey: String = "4f5c62f312dd179fa66327da5db9e5f3"
    
    init(page: Int = 1){
        self.page = page
    }
    var url: String {
        let baseURL: String = "https://api.themoviedb.org/3"
        let path: String = "/trending/all/day"
        return baseURL + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "api_key": apiKey,
            "page": "\(page)"
        ]
    }
    
    var method: HTTPMethod {
        .GET
    }
}
