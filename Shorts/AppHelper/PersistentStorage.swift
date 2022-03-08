//
//  PersistentStorage.swift
//  Shorts
//
//  Created by Rohit Saini on 07/03/22.
//

import Foundation
import CoreData


protocol CDMovieDelegate{
    func create(movie: Movie)
    func getAllMovies() -> [Movie]?
    func get(byIdentifier id: Double) -> Movie?
    func update(movie: Movie)
    func delete(movie: Movie)
}


extension CDMovieDelegate{
    func create(movie: Movie) {
        let request = ImageRequest(url: movie.posterURL)
        ImageClient.shared.downloadImageData(request: request) { imageData in
            let cdMovie = CDMovie(context: PersistentStorage.shared.context)
            cdMovie.id = Double(movie.id)
            cdMovie.originalTitle = movie.originalTitle
            cdMovie.overview = movie.overview
            cdMovie.posterURL = imageData
            PersistentStorage.shared.saveContext()
        }
        
    }
    
    func getAllMovies() -> [Movie]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDMovie.self)
        var movies: [Movie] = []
        result?.forEach({ cdMovie in
            movies.append(cdMovie.convertToMovie())
        })
        return movies
    }
    
    func get(byIdentifier id: Double) -> Movie? {
        let fetchRequest = NSFetchRequest<CDMovie>(entityName: "CDMovie")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do{
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result?.convertToMovie()
        }
        catch let error{
            print(error)
        }
        return nil
    }
    
    func update(movie: Movie) {
        
    }
    
    func delete(movie: Movie) {
        
    }
    
}


final class PersistentStorage{
    private init(){}
    static let shared = PersistentStorage()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Shorts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]?{
        do{
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            return result
        }
        catch let error{
            print(error)
        }
        return nil
    }

}
