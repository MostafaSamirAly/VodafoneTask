//
//  MainViewmodel.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import Foundation
enum PhotosDataSource {
    case network
    case cashed
}
class MainViewmodel: NSObject {
    private let parser:RepositoryParser
    private let fetcher:RepositoryFetcher
    private var cashedPhotos:[Photo] {
        return CoreDataHelper.shared.getMoviesFromCoreData()
    }
    private var photos = [Photo]() {
        didSet {
            updateCashedMovies()
        }
    }
    private var numberOfAds: Int {
        switch photosDataSource {
        case .network:
            return photos.count / 5
        case .cashed:
            return cashedPhotos.count / 5
        }
    }
    private var page = 1
    private var hasMore = false
    private var photosDataSource:PhotosDataSource = .network
    
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
            self.photosDataSource = .cashed
            self.errorCompletion?(error)
        }
    }
    
    func loadMore() {
        if hasMore {
            page += 1
            getData()
        }
    }
    
    func getLastIndex()-> Int {
        switch photosDataSource {
        case .network:
            return photos.count + numberOfAds
        case .cashed:
            return cashedPhotos.count + numberOfAds
        }
    }
    
    func getTotalCount() -> Int {
        let count:Int = getLastIndex()
        return hasMore ? count + 1 : count
    }
    
    func isAd(at indexPath: IndexPath) -> Bool {
        return (indexPath.row + 1) % 6 == 0 && indexPath.row != 0
    }
    
    func getPhoto(at indexPath: IndexPath) -> Photo {
        switch photosDataSource {
        case .network:
            return photos[indexPath.row - (indexPath.row / 6)]
        case .cashed:
            return cashedPhotos[indexPath.row - (indexPath.row / 6)]
        }
        
    }
    
    private func updateCashedMovies() {
        if cashedPhotos.count <  20 {
            CoreDataHelper.shared.insert(photos: photos.suffix(20))
        }
    }
}
