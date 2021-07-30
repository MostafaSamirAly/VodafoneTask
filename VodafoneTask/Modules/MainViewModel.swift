//
//  MainViewmodel.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import Foundation
enum PhotosDataSource {
    case network
    case cache
}
class MainViewModel: NSObject {
    private let parser: RepositoryParser
    private let fetcher: RepositoryFetcher
    var cachedPhotos: [Photo] {
        return CoreDataHelper.shared.getMoviesFromCoreData()
    }
    var photos = [Photo]() {
        didSet {
            updateCachedPhotos()
        }
    }
    private(set) var selectedPhoto: Photo?
    private var adsNumber: Int {
        switch photosDataSource {
        case .network:
            return photos.count / 5
        case .cache:
            return cachedPhotos.count / 5
        }
    }
    private var page = 1
    private var hasMore = false
    private var photosDataSource:PhotosDataSource = .network
    
    var successCompletion: (() -> Void )?
    var errorCompletion: ((Error) -> Void )?
    
    override init() {
        parser = RepositoryParser()
        fetcher = RepositoryFetcher(parser: parser)
        super.init()
    }
    
    /// Use this Method to fetch data from backend
    func fetchData() {
        fetcher.fetch(at: Int32(page)) { [weak self] photos in
            self?.hasMore = !photos.isEmpty
            self?.photos.append(contentsOf: photos)
            self?.successCompletion?()
        } error: { [weak self] error in
            self?.hasMore = false
            if self?.photos.count == 0 {
                self?.photosDataSource = .cache
            }
            self?.errorCompletion?(error)
        }
    }
    
    /// Use this Method to paginate
    func loadMore() {
        if hasMore {
            page += 1
            fetchData()
        }
    }
    
    /// Use this function to refresh fetched data
    func refresh() {
        hasMore = false
        photos.removeAll()
        photosDataSource = .network
        page = 1
        fetchData()
    }
     
    /// Use this Method to get the last index of the current data source and number of ads
    func lastIndex()-> Int {
        switch photosDataSource {
        case .network:
            return photos.count + adsNumber
        case .cache:
            return cachedPhotos.count + adsNumber
        }
    }
    
    /// Use this method to know the number of the data source and the ads
    /// - Warning: The number may be greater than expected by 1 if there is more to get from backend
    func totalCount() -> Int {
        let count = lastIndex()
        return hasMore ? count + 1 : count
    }
    
    
    /// Use this method to know if the indexPath is at ad location or not
    /// - Parameter indexPath: current indexPath
    func isAd(at indexPath: IndexPath) -> Bool {
        return (indexPath.row + 1) % 6 == 0 && indexPath.row != 0
    }
    
    /// Use this method to get the appropriate photo at indexPath
    /// - Parameter indexPath: current indexPath
    func photo(at indexPath: IndexPath) -> Photo {
        switch photosDataSource {
        case .network:
            return photos[indexPath.row - (indexPath.row / 6)]
        case .cache:
            return cachedPhotos[indexPath.row - (indexPath.row / 6)]
        }
        
    }
    
    func setSelectedPhoto(at indexPath: IndexPath) {
        selectedPhoto = photo(at: indexPath)
    }
    
    /// Use this method to update cashed photos in the core data
    private func updateCachedPhotos() {
        if cachedPhotos.count <  20 {
            CoreDataHelper.shared.insert(photos: photos.suffix(20))
        }
    }
}
