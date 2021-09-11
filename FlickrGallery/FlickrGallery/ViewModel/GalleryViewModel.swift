//
//  GalleryViewModel.swift
//  FlickrGallery
//
//  Created by Jain, Vikas on 10/9/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

// Delegate to handle the communication back to view controller with the gallery/image data
protocol GalleryViewModelDelegate: NSObject {
    
    /// Callback delegate when gallery data is fetched successfully
    /// - Parameter value: The gallery data response
    func galleryInfo(_ value: Photos)
    
    /// Error handler callback
    /// - Parameter error: Error object
    func handleError(_ error: APIError)
}

class GalleryViewModel {
    // MARK: - Properties
    var galleryData: Gallery?
    let serviceRequestCoordinator: ServiceRequestPerforming
    
    weak var viewModelDelegate: GalleryViewModelDelegate?
    
    // MARK: - Initializer
    
    init(serviceCoordinator: ServiceRequestPerforming = ServiceRequestCoordinator(),
         delegate: GalleryViewModelDelegate) {
        self.serviceRequestCoordinator = serviceCoordinator
        self.viewModelDelegate = delegate
    }
    
    // MARK: - Public Methods
    
    /// To fetch the gallery data for image gallery
    /// - Parameters:
    ///   - text: Search text entered by user
    ///   - currentPage: Current page that is loaded
    func getGalleryInfo(for text: String, currentPage: Int = 0) {
        self.serviceRequestCoordinator.fetchGalleryData(for: text, pageNum: currentPage + 1, onCompletion: { (result) in
            switch result {
            case .success(let value):
                self.viewModelDelegate?.galleryInfo(value)
            case .failure(let error):
                //NOTE: If needed we can log the error here in log file or call the Error handler as well
                self.viewModelDelegate?.handleError(error)
            }
        })
    }
    
    
    /// To get the image for the gallery object
    /// - Parameters:
    ///   - galleryObject: Gallery object for which image is to be fetched
    ///   - onCompletion: Completion callback
    func getGalleryImage(for galleryObject: FlickrImage, onCompletion: @escaping(Result<Data, APIError>) -> Void) {
        self.serviceRequestCoordinator.fetchGalleryImage(galleryObject: galleryObject) { (result) in
            switch result {
            case .success(let value):
                onCompletion(.success(value))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
