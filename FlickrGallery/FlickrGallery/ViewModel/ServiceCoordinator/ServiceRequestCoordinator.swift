//
//  ServiceManager.swift
//  FlickrImage
//
//  Created by Jain, Vikas on 29/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation
import Alamofire

/// This protocol will be used to fetch the gallery data and images from the API
protocol ServiceRequestPerforming {
    
    /// To fetch the gallery data from Flickr API
    /// - Parameters:
    ///   - text: Search text entered by user
    ///   - pageNum: Page number to be fetched
    ///   - onCompletion: Completion closure
    func fetchGalleryData(for text: String, pageNum: Int, onCompletion: @escaping(Result<Photos, APIError>) -> Void)
    
    /// To fetch the gallery image
    /// - Parameters:
    ///   - galleryObject: Gallery object with image details
    ///   - onCompletion: Completion closure
    func fetchGalleryImage(galleryObject: FlickrImage, onCompletion: @escaping(Result<Data, APIError>) -> Void)
}

class ServiceRequestCoordinator: ServiceRequestPerforming {
    
    func fetchGalleryData(for text: String, pageNum: Int, onCompletion: @escaping(Result<Photos, APIError>) -> Void) {
        let request = GalleryRequest(searchText: text, page: pageNum)
        
        AF.request(request.path, method: .get, parameters: request.requestParams()).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let galleryData = try decoder.decode(Photos.self, from: data!)
                    onCompletion(.success(galleryData))
                }
                catch {
                    onCompletion(.failure(APIError.responseDecodingError))
                }
            case .failure(_):
                onCompletion(.failure(APIError.serviceUnavailable))
            }
        }
    }
    
    func fetchGalleryImage(galleryObject: FlickrImage, onCompletion: @escaping(Result<Data, APIError>) -> Void) {
        let imageRequest = ImageRequest(image: galleryObject)
        if let imageUrl = URL(string: imageRequest.path) {
            AF.request(imageUrl).response { response in
                switch response.result {
                case .success(let responseData):
                    onCompletion(.success(responseData!))
                case .failure(_):
                    onCompletion(.failure(APIError.serviceUnavailable))
                }
            }
        }
    }
}
