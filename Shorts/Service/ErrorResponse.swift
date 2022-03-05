//
//  ErrorResponse.swift
//  Shorts
//
//  Created by Rohit Saini on 04/03/22.
//

import Foundation

//MARK: - ErrorResponse
enum ErrorResponse: String {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var description: String {
        switch self {
            case .apiError: return "Ooops, there is something problem with the api"
            case .invalidEndpoint: return "Ooops, there is something problem with the endpoint"
            case .invalidResponse: return "Ooops, there is something problem with the response"
            case .noData: return "Ooops, there is something problem with the data"
            case .serializationError: return "Ooops, there is something problem with the serialization process"
        }
    }
}
