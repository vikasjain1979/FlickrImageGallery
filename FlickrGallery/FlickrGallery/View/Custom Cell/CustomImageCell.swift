//
//  CustomImageCell.swift
//  FlickrGallery
//
//  Created by Jain, Vikas on 10/9/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import UIKit

/// Custom cell class for UICollectionView to show the image
final class CustomImageCell: UICollectionViewCell {
    //MARK:- Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Public Methods
    
    /// Configure the cell to show downloaded image or placeholder image (in case of failure) and hide the activity indicator
    /// - Parameter image: UIImage downloaded using the URL
    public func configureCell(image: UIImage?) {
        self.hideActivityIndicator()
        if let image = image {
            self.imageView.image = image
        } else {
            // Placeholder image
            self.imageView.image = UIImage(named: "no_image_placeholder")
        }
    }
    
    /// Show the activity indicator when an image is being loaded
    public func showActivityIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.imageView.isHidden = true
    }
    
    /// Hides the activity indicator and shows the image view
    public func hideActivityIndicator() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.imageView.isHidden = false
    }
}
