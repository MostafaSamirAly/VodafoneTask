//
//  MainViewmodel.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import Foundation

class MainViewmodel: NSObject {
    private let parser:RepositoryParser
    private let fetcher:RepositoryFetcher
    private(set) var photos = [Photo]() {
        didSet {
            numberOfAds = photos.count / 5
        }
    }
    private(set) var numberOfAds = 0
    private var page = 1
    private(set) var hasMore = false
    
    var successCompletion:(()->())?
    var errorCompletion:((Error)->())?
    
    override init() {
        parser = RepositoryParser()
        fetcher = RepositoryFetcher(parser: parser)
        super.init()
    }
    
    func getData() {
        fetcher.fetch(at: Int32(page)) { [weak self] photos in
            self?.hasMore = !photos.isEmpty
            self?.photos.append(contentsOf: photos)
            self?.successCompletion?()
        } error: { error in
            self.errorCompletion?(error)
        }
    }
    
    func loadMore() {
        if hasMore {
            page += 1
            getData()
        }
    }
    
    func isAd(at indexPath:IndexPath) -> Bool {
        return (indexPath.row + 1) % 6 == 0 && indexPath.row != 0
    }
    
    func getPhoto(at indexPath:IndexPath) -> Photo {
        return photos[indexPath.row - (indexPath.row / 6)]
    }
}
