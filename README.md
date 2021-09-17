# FlickrImageGallery

![image](https://user-images.githubusercontent.com/58238694/133721980-eb7f349d-073a-4377-a482-7e75ccec9dad.png)


FlickrImageGallery is a basic solution to handle the gallery images which is implemnented using MVVM architecture.

# Dependencies

**Alamofire**

This project uses Alamofire as a dependency which is updated using the Swift Package Manager (SPM)

# Description

- Getting the remote images from the Flickr API based on the search text.
- Getting images based on page (with 30 images per page)
- Pagination fetches next set of images when user scrolls to bottom of collectionview.
- Showing loader icon while image is loading
- 'Placeholder image' in case of image fetch failure
- Reset the search data when searchText changes.


•	For API calls I have integrated with Alamofire(v5.4.3) using SPM

•	Unit Tests: Added unit tests for all public methods of ViewModel

•	Error Handling: Handling error for any API failures using the Error object 

# Usage

## To edit number of columns per row
Change the value in `GalleryViewController.swift`

```
let cellsPerRow = 3
```


## To add/remove/edit request parameters
Change the value in `GalleryRequest.swift`

```
    var searchText: String = "kittens"
    var method: String = "flickr.photos.search"
    var api_key = "96358825614a5d3b1a1c3fd87fca2b47"
    var format = "json"
    var nojsoncallback = 1
    var page: Int = 1
    var per_page = 30
```

## To customize error messages
Refer to the `APIError.swift` 

```
public enum APIError: Error {
    // MARK: - Error Codes
    // Can add more codes here e.g. 4XX, 5XX or business specifc error codes
    case serviceUnavailable
    case responseDecodingError
}

extension APIError: ErrorMessageProviding {
    var alertTitle: String {
        switch self {
        case .serviceUnavailable:
            return "Service Unavailable"
        case .responseDecodingError:
            return "Something Went Wrong"
        }
    }
    
    var alertMessage: String {
        switch self {
        case .serviceUnavailable:
            return "There seems to be some problem in contacting the server. Please try again later."
        case .responseDecodingError:
            return "Something Went Wrong"
        }
    }
}
```

# NFRs

- Device orientation support
  * Supports both portrait and landscape mode

- Device Size check
   * Tested on iPhone 8 and iPhone 12
   * Have used constraints so should be good on other devices as well
   * Runs on iPad as well

- Supported OS Version
   * iOS 13 and above 

- Accessibility
   * Supports and tested for voiceover accessibility

