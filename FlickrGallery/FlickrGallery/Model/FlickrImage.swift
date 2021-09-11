//
//  FlickrImage.swift
//  FlickrGallery
//
//  Created by Jain, Vikas on 10/9/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

struct FlickrImage: Decodable {
    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var ispublic: Int
    var isfriend: Int
    var isfamily: Int
}
