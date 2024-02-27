//
//  HomeViewModel.swift
//  NYTimes
//
//  Created by Madhuri Agrawal on 20/02/24.
//

import Foundation

class HomeViewModel {
    var delegate: HomePageDelegate?
    let pendingOperations = DownloadingOperations()
    var newsItems: [NewsDetailInfo]?
    var photos = Array<ProfilePhoto>()
    func fetchMostPopularNews() {
        let loader = WebServices()
        let url = HttpURL.mostviewed.localised
        let request = HeaderRequest().getRequest(httpMethod: .Get, url: url)
        loader.load(NewsModel.self, request: request ) { result in
            switch result {
            case .success(let response):
                self.newsItems = response?.results
                self.getPhotoModel()
                self.delegate?.updateView(nil)
            case .failure(let error):
                self.delegate?.updateView(error.localizedDescription)
            }
        }
    }
    private func getPhotoModel() {
        newsItems?.forEach({ details in
            let media = details.media?.first(where: {$0.mediaMetadata?.contains(where: {$0.format == .standardThumbnail}) ?? false})?.mediaMetadata?.first
            let photo = ProfilePhoto(id: details.id ?? 0, url: media?.url)
            photos.append(photo)
        })
        
    }
    func startOperations(photoRecord: ProfilePhoto) {
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
    deinit {
        delegate = nil
    }
}
