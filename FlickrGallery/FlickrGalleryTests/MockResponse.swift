//
//  MockResponse.swift
//  StarShipTests
//
//  Created by Jain, Vikas on 31/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

@testable import FlickrGallery

final class MockResponse {
    static func makeResponse() -> Photos? {
        let bundle = Bundle(for: self)
        guard let apiUrl = bundle.url(forResource: "flickr_api", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: apiUrl)
            guard let galleryData = try? JSONDecoder().decode(Photos.self, from: data) else {
                return nil
            }
            
            return galleryData
        } catch _ {
            return nil
        }
    }
}
    
