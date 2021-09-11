//
//  Gallery.swift
//  FlickrGallery
//
//  Created by Jain, Vikas (Cognizant) on 10/9/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

struct Photos: Decodable {
    var photos: Gallery
    var stat: String
}

struct Gallery: Decodable {
    var page: Int
    var pages: Int
    var perpage: Int
    var total: Int
    var images: [FlickrImage]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case total
        case images = "photo"
    }
}
