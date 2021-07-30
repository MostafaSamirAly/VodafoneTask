//
//  CoreDataManager.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 26/07/2021.
//

import UIKit
import CoreData

private enum CoreDataConstants: String {
    case photoId
    case downloadUrl
    case author
}

class CoreDataHelper {
    static let shared = CoreDataHelper()
    let managedContext : NSManagedObjectContext
    var retrievedData : Array<NSManagedObject> = []
    private init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }else {
            managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
        
    }
    
    func getMoviesFromCoreData(entityName : String = "PhotoEntity") -> [Photo] {
        var photos = [Photo]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        
        do {
            retrievedData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
        if retrievedData.count != 0 {
            photos = retrievedData.compactMap {
                Photo(author: ($0.value(forKey: CoreDataConstants.author.rawValue) as? String) ?? "Couldn't get author",
                      andDownloadUrl: ($0.value(forKey: CoreDataConstants.downloadUrl.rawValue) as? String) ?? "Couldn't get downloadUrl")
            }
        }
        return photos
    }
    
    
    
    func insert(photos:[Photo],into entityName: String = "PhotoEntity") -> Void {
        DeleteAllPhotos()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
        for photo in photos {
            let photoToInsert = NSManagedObject(entity: entity!, insertInto: managedContext)
            photoToInsert.setValue(photo.author, forKey: CoreDataConstants.author.rawValue)
            photoToInsert.setValue(photo.downloadUrl, forKey: CoreDataConstants.downloadUrl.rawValue)
            do{
                try managedContext.save()
            } catch let error as NSError {
                print(error)
            }
        }
        
    }
    
    private func DeleteAllPhotos(entityName : String = "PhotoEntity") -> Void{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object)
                do{
                    try managedContext.save()
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
}
