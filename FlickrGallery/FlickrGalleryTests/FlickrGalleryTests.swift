//
//  FlickrGalleryTests.swift
//  FlickrGalleryTests
//
//  Created by Jain, Vikas (Cognizant) on 9/9/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import XCTest
@testable import FlickrGallery

class FlickrGalleryTests: XCTestCase {
    
    var mockService: MockService<Photos>!
    var viewModel: GalleryViewModel!
    var successExpectation: XCTestExpectation!
    var failureExpectation: XCTestExpectation!
    var galleryData: Photos!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mockService = MockService()
        self.mockService.mockResponse = MockResponse.makeResponse()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetGalleryDataSuccess() {
        self.successExpectation = XCTestExpectation(description: "The gallery information is fetched")
        viewModel = GalleryViewModel(serviceCoordinator: mockService, delegate: self)
        viewModel.getGalleryInfo(for: "test")
        self.wait(for: [successExpectation], timeout: 1.0)
    }
    
    func testGetGalleryDataFailure() {
        self.mockService.isForcedError = true
        self.failureExpectation = XCTestExpectation(description: "The API response should fail")
        viewModel = GalleryViewModel(serviceCoordinator: mockService, delegate: self)
        viewModel.getGalleryInfo(for: "test")
        self.wait(for: [failureExpectation], timeout: 1.0)
    }
    
    func testImageDownload() {
        let image = FlickrImage(id: "1", owner: "test", secret: "test", server: "server", farm: 1, title: "title", ispublic: 1, isfriend: 1, isfamily: 1)
        viewModel = GalleryViewModel(serviceCoordinator: mockService, delegate: self)
        viewModel.getGalleryImage(for: image) { result in
            switch result {
            case .success(let imageData):
                let bundle = Bundle.init(for: FlickrGalleryTests.self)
                XCTAssertEqual(imageData, UIImage(named: "Image5.jpg", in: bundle, compatibleWith: nil)?.pngData())
            case .failure(_):
                XCTFail("Image should match")
            }
        }
    }
    
    func testImageRequest() {
        let image = FlickrImage(id: "1", owner: "test", secret: "secret", server: "server", farm: 1, title: "title", ispublic: 1, isfriend: 1, isfamily: 1)
        let imageRequest = ImageRequest(image: image)
        XCTAssertEqual(imageRequest.path, "http://farm1.static.flickr.com/server/1_secret.jpg")
    }
}


extension FlickrGalleryTests: GalleryViewModelDelegate {
    func galleryInfo(_ value: Photos) {
        if (value.photos.images.count > 0 ) {
            self.galleryData = value
            self.successExpectation.fulfill()
        } else {
            XCTFail()
        }
    }
    
    func handleError(_ error: APIError) {
        if error == .serviceUnavailable {
            self.failureExpectation.fulfill()
        } else {
            XCTFail()
        }
    }
}

