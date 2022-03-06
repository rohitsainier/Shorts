//
//  ImageClient.swift
//  Shorts
//
//  Created by Rohit Saini on 06/03/22.
//

import Foundation
import UIKit

protocol ImageClientService{
    func downloadImage<Request: DataRequest>(request: Request, completion: @escaping (UIImage?,Error?) -> Void)
    func setImage(from url: String,placeholderImage: UIImage?, completion: @escaping (UIImage?) -> Void)
}

final class ImageClient{
    static let shared = ImageClient(responseQueue: .main, session: URLSession.shared)
    
    
    private(set) var cachedImageForURL = SwiftlyLRU<String, UIImage>(capacity: 40)
    
    let responseQueue: DispatchQueue?
    let session: URLSession
    
    private init(responseQueue: DispatchQueue?, session: URLSession) {
        self.responseQueue = responseQueue
        self.session = session
    }
    
    private func dispatchImage(image: UIImage? = nil, error: Error? = nil,completion: @escaping (UIImage?, Error?) -> Void) {
        guard let responseQueue = responseQueue else {
            completion(image, error)
            return
        }
        
        responseQueue.async {
            completion(image, error)
        }
    }
    
}

extension ImageClient: ImageClientService {
    func downloadImage<Request: DataRequest>(request: Request, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let service: NetworkService = DefaultNetworkService()
        
        service.request(request) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
                case .success(let response):
                    guard let image: UIImage = response as? UIImage else {
                        return
                    }
                    
                    self.dispatchImage(image: image, completion: completion)
                case .failure(let error):
                    self.dispatchImage(error: error, completion: completion)
            }
        }
    }
    
    func setImage(from url: String, placeholderImage: UIImage?, completion: @escaping (UIImage?) -> Void) {
        let request = ImageRequest(url: url)
        if let cacheImage = cachedImageForURL[url] {
            completion(cacheImage)
        } else {
            downloadImage(request: request) { [weak self] image, error in
                guard let self = self else {
                    return
                }
                
                guard let image = image else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                self.cachedImageForURL[url] = image
                completion(self.cachedImageForURL[url])
            }
        }
    }
}
