//
//  CoreDataManager.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 26/07/2021.
//

import UIKit
import CoreData
class CoreDataHelper {
    enum CoreDataConstants: String {
        case photoId
        case downloadUrl
        case author
    }
    static let shared = CoreDataHelper()
    let managedContext : NSManagedObjectContext?
    var retrievedData : Array<NSManagedObject> = []
    private init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate!.persistentContainer.viewContext
    }
    
    func getMoviesFromCoreData(entityName : String = "PhotoEntity") -> [Photo] {
        var rtnPhotos = [Photo]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        
        do {
            retrievedData = try managedContext!.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
        if retrievedData.count != 0{
            for data in retrievedData {
                let photo = Photo()
                photo.author = data.value(forKey: CoreDataConstants.author.rawValue) as! String
                photo.downloadUrl = data.value(forKey: CoreDataConstants.downloadUrl.rawValue) as! String
                rtnPhotos.append(photo)
            }
        }
        return rtnPhotos
    }
    
    
    
    func insert(photos:[Photo],into entity: String = "PhotoEntity") -> Void {
        DeleteAllPhotos()
        let entity = NSEntityDescription.entity(forEntityName: entity, in: managedContext!)
        for photo in photos {
            let photoToInsert = NSManagedObject(entity: entity!, insertInto: managedContext)
            photoToInsert.setValue(photo.author, forKey: CoreDataConstants.author.rawValue)
            photoToInsert.setValue(photo.downloadUrl, forKey: CoreDataConstants.downloadUrl.rawValue)
            do{
                try managedContext?.save()
            }catch let error as NSError{
                print(error)
            }
        }
        
    }
    
    private func DeleteAllPhotos(entityName : String = "PhotoEntity") -> Void{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        if let result = try? managedContext!.fetch(fetchRequest) {
            for object in result {
                managedContext!.delete(object)
                do{
                    try managedContext!.save()
                }catch let error as NSError{
                    print(error)
                }
            }
        }
    }

    
}
