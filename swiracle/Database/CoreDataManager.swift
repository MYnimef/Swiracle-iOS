//
//  CoreDataManager.swift
//  Swiracle
//
//  Created by Ivan Markov on 09.11.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    public static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "SwiracleModels")
        persistentContainer.loadPersistentStores { desription, error in
            if let error = error {
                fatalError("You're dumb \(error)")
            }
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
                print(error)
            }
        }
    }
    
    func deleteAllPosts() {
        for i in getAllPosts() {
            viewContext.delete(i)
        }
    }
    
    func getAllPosts() -> [Post] {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
            
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
