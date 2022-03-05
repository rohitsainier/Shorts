//
//  ImageRequest.swift
//  Shorts
//
//  Created by Rohit Saini on 06/03/22.
//

import Foundation
import UIKit

struct ImageRequest: DataRequest {
    
    let url: String
    
    var method: HTTPMethod {
        .GET
    }
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NSError(
                domain: ErrorResponse.invalidResponse.rawValue,
                code: 13,
                userInfo: nil
            )
        }
        
        return image
    }
}
