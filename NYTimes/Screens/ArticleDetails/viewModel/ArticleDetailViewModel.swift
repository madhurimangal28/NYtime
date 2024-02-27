//
//  ArticleDetailViewModel.swift
//  NYTimes
//
//  Created by Madhuri Agrawal on 21/02/24.
//

import Foundation

class ArticleDetailViewModel {
    var delegate: HomePageDelegate?
    let pendingOperations = DownloadingOperations()
    private let details: NewsDetailInfo?
    private let photoRecord: ProfilePhoto?
    init(_ details: NewsDetailInfo?) {
        self.details = details
        let media = self.details?.media?.first(where: {$0.type == .image})?.mediaMetadata?.first(where: {$0.format == .mediumThreeByTwo440})?.url
        photoRecord = ProfilePhoto(id: details?.id ?? 0, url: media)
    }
    var model: ArticleDetails? {
        let media = self.details?.media?.first(where: {$0.type == .image})?.mediaMetadata?.first(where: {$0.format == .standardThumbnail})?.url
        let model = ArticleDetails(title: self.details?.title,
                                   abstract: self.details?.abstract,
                                   media: media,
                                   id: self.details?.id,
                                   imageData: photoRecord?.imageData)
        return model
    }
    func startOperations() {
        guard let photoRecord = photoRecord else {
            return
        }
        if( photoRecord.photoState == PhotoRecordState.new) {
            startDownload(photoRecord: photoRecord)
        }
    }
    
    private func startDownload(photoRecord: ProfilePhoto) {
        
        guard pendingOperations.downloadsInProgress[photoRecord.id] == nil else {
            return
        }
        
        let downloader = ImageDownloadManager(photoRecord: photoRecord)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: photoRecord.id)
                self.delegate?.updateView(nil)
            }
        }
        
        pendingOperations.downloadsInProgress[photoRecord.id] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}
