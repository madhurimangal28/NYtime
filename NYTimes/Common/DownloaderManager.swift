//
//  DownloaderManager.swift
//  Madhuri
//
//  Created by Madhuri Agrawal on 24/08/20.
//  Copyright © 2020 Madhuri Agrawal. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, UIImage>()

class DownloadingOperations {
    lazy var downloadsInProgress: [String: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Downloading_queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class ImageDownloadManager: Operation {
    
    let  photoRecord: ProfilePhoto
    
    init( photoRecord: ProfilePhoto) {
        self.photoRecord = photoRecord
    }
    
    override func main() {
        
        if isCancelled {
            return
        }
        let url = photoRecord.url ?? ""
        
        // check cached image
        
        guard let imgURL = URL(string: url) else {
            photoRecord.photoState = PhotoRecordState.failed
            return
            
        }
        let key = NSString(format: "%i", photoRecord.id)
        
        if let cachedImage = imageCache.object(forKey: key)  {
            if let imageData = cachedImage.pngData() {
                photoRecord.imageData = imageData
                photoRecord.photoState = PhotoRecordState.downloaded
                return
            }
        }
        
        
        guard let imageData = try? Data(contentsOf: imgURL) else { return }
        
        if isCancelled {
            return
        }
        
        
        if !imageData.isEmpty {
            
            DispatchQueue.main.async {
                imageCache.setObject(UIImage(data: imageData)!, forKey: key )
            }
            photoRecord.imageData = imageData
            photoRecord.photoState = PhotoRecordState.downloaded
            
        } else {
            photoRecord.photoState = PhotoRecordState.failed
            photoRecord.imageData = UIImage(named: "placeholder")?.pngData()
        }
    }
}
