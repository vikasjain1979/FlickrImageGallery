//
//  ViewController.swift
//  FlickrGallery
//
//  Created by Jain, Vikas on 10/9/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import UIKit

final class GalleryViewController: UICollectionViewController {
    
    //MARK:- Properties
    
    private let cellReuseIdentifier = "ImageCell"
    private var galleryModel: Gallery?
    private var galleryViewModel: GalleryViewModel?
    private var currentSearchText = ""
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // Properties to set cell margin and inset
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow = 3
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Initialize properties
        self.galleryViewModel = GalleryViewModel(delegate: self)
    }
    
    //MARK:- Events
    @IBAction func searchTextEntered(_ sender: UITextField) {
        searchTextField.resignFirstResponder()
        
        // Reset the model when search text changes
        if let searchText = self.searchTextField.text, !searchText.isEmpty, currentSearchText != searchText {
            self.currentSearchText = searchText
            self.galleryModel = nil
            self.galleryViewModel?.getGalleryInfo(for: searchText)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension GalleryViewController {
    // MARK: - UICollectionView delegate methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryModel?.images.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CustomImageCell
        
        if let image = self.galleryModel?.images[indexPath.row] {
            cell.showActivityIndicator()
            self.galleryViewModel?.getGalleryImage(for: image, onCompletion: { (result) in
                switch result {
                case .success(let imageData):
                    cell.configureCell(image: UIImage(data: imageData))
                case .failure(_):
                    cell.configureCell(image: nil)
                }
            })
        }
        
        return cell
    }
    
    /// To fetch the next set of images from API when last set of images are displayed
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let model = self.galleryModel, indexPath.row == model.images.count - 1 {
            self.galleryViewModel?.getGalleryInfo(for: self.searchTextField.text ?? "", currentPage: model.page)
        }
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// Get total margin and inset and split the remaining screen width between each cell
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension GalleryViewController: GalleryViewModelDelegate {
    func galleryInfo(_ value: Photos) {
        if let _ = self.galleryModel {
            self.galleryModel?.page = value.photos.page
            self.galleryModel?.images.append(contentsOf: value.photos.images)
        } else {
            self.galleryModel = value.photos
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func handleError(_ error: APIError) {
        // NOTE: We can show an error alert here depending on the requiresment
        print("error: \(error.alertTitle): \(error.alertMessage)")
    }
}
