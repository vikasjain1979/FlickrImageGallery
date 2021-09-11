//
//  ImageRequest.swift
//  FlickrGallery
//
//  Created by Jain, Vikas (Cognizant) on 11/9/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

/// Request class for fetching the Gallery data from Flickr API
final class ImageRequest {
    let imagePath = "http://farm%i.static.flickr.com/%@/%@_%@.jpg"
    var image: FlickrImage
    var path: String {
        return String(format: imagePath, image.farm, image.server, image.id, image.secret)
    }
    
    init(image: FlickrImage) {
        self.image = image
    }
}
