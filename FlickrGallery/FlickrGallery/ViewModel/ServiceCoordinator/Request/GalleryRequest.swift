//
//  GalleryRequest.swift
//  FlickrGallery
//
//  Created by Jain, Vikas on 10/9/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

/// Request class for fetching the Gallery data from Flickr API
final class GalleryRequest: Codable {
    
    // NOTE: These properties and parameters can be exposed via Protocol e.g. RequestConfiguration. This can then be implemented by
    // all requests in the application.
    
    //MARK: - Request Properties
    var path: String
    
    //MARK: - Request Parameters
    var searchText: String = "kittens"
    var method: String = "flickr.photos.search"
    var api_key = "96358825614a5d3b1a1c3fd87fca2b47"
    var format = "json"
    var nojsoncallback = 1
    var page: Int = 1
    var per_page = 30
    
    init(path: String = "https://api.flickr.com/services/rest/", searchText: String, page: Int) {
        self.path = path
        self.searchText = searchText
        self.page = page
    }
    
    //MARK: - Public methods
    
    /// Return the request parameters as a dictionary
    func requestParams() -> [String: Any] {
        return ["method": self.method,
                "api_key": self.api_key,
                "format": self.format,
                "nojsoncallback": self.nojsoncallback,
                "page": String(self.page),
                "per_page": String(self.per_page),
                "text": self.searchText]
    }
}
