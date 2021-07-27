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
            updateCashedPhotos()
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
    
    /// Use this Method to fetch data from backend
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
    
    /// Use this Method to paginate
    func loadMore() {
        if hasMore {
            page += 1
            getData()
        }
    }
     
    /// Use this Method to get the last index of the current data source and number of ads
    func getLastIndex()-> Int {
        switch photosDataSource {
        case .network:
            return photos.count + numberOfAds
        case .cashed:
            return cashedPhotos.count + numberOfAds
        }
    }
    
    /// Use this method to know the number of the data source and the ads
    /// - Warning: The number may be greater than expected by 1 if there is more to get from backend
    func getTotalCount() -> Int {
        let count:Int = {
            switch photosDataSource {
        case .network:
            return photos.count + numberOfAds
        case .cashed:
            return cashedPhotos.count + numberOfAds
        }
        }()
        return hasMore ? count + 1 : count
    }
    
    /// Use this method to know if the indexpath is at ad location or not
    func isAd(at indexPath: IndexPath) -> Bool {
        return (indexPath.row + 1) % 6 == 0 && indexPath.row != 0
    }
    
    /// Use this method to get the appropriate photo at indexpath
    func getPhoto(at indexPath: IndexPath) -> Photo {
        switch photosDataSource {
        case .network:
            return photos[indexPath.row - (indexPath.row / 6)]
        case .cashed:
            return cashedPhotos[indexPath.row - (indexPath.row / 6)]
        }
        
    }
    
    /// Use this method to update cashed photos in the coredata
    private func updateCashedPhotos() {
        if cashedPhotos.count <  20 {
            CoreDataHelper.shared.insert(photos: photos.suffix(20))
        }
    }
}
