//
//  MockService.swift
//  StarShipTests
//
//  Created by Jain, Vikas on 31/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Alamofire
import Foundation
import XCTest

@testable import FlickrGallery

public final class MockService<T>: ServiceRequestPerforming {
    
    public var mockResponse: T?
    public var isForcedError: Bool = false
    
    public func fetchGalleryData(for text: String, pageNum: Int, onCompletion: @escaping (Result<Photos, APIError>) -> Void) {
        if self.isForcedError {
            onCompletion(.failure(.serviceUnavailable))
        } else {
            if let response = self.mockResponse as? Photos {
                onCompletion(.success(response))
            } else {
                XCTFail("Response failure")
            }
        }
    }
    
    public func fetchGalleryImage(galleryObject: FlickrImage, onCompletion: @escaping (Result<Data, APIError>) -> Void) {
        if self.isForcedError {
            onCompletion(.failure(.serviceUnavailable))
        } else {
            let bundle = Bundle.init(for: FlickrGalleryTests.self)
            let image = UIImage(named: "Image5.jpg", in: bundle, compatibleWith: nil)
            if let imageData = image?.pngData() {
                onCompletion(.success(imageData))
            } else {
                XCTFail("Response failure")
            }
        }
    }
}
