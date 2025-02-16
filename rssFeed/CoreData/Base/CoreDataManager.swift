//
//  CoreDataManager.swift
//  rssFeed
//
//  Created by Toni Pavic on 01.02.2025..
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyRSSFeed")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearAllData() {
        let context = persistentContainer.viewContext
        let entities = persistentContainer.managedObjectModel.entities.compactMap { $0.name }
        
        entities.forEach { entityName in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(batchDeleteRequest)
            } catch {
                print("Failed to delete all objects in \(entityName): \(error)")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save context after deletion: \(error)")
        }
    }
}
