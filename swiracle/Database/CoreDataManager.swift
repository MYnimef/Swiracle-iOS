//
//  CoreDataManager.swift
//  Swiracle
//
//  Created by Ivan Markov on 09.11.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    public static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    public var viewContext: NSManagedObjectContext {
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
    
    private var network = PostsGetter()
    
    func downloadAllPosts() {
        network.download()
    }
    
    func updateAllPosts(data: [PostInfoJSON]) {
        self.deleteAllPosts()
            
        var posts = [Post]()
        for i in data {
            let post = Post(context: self.viewContext)
            post.id = i.id
            post.username = i.username
            post.title = i.title
            post.price = Int64(i.price.rub)
            post.likesAmount = Int64(i.likesAmount)
            post.commentsAmount = Int64(i.commentsAmount)
            post.isLiked = false
                
            posts.append(post)
        }
                
        if self.viewContext.hasChanges {
            do {
                try self.viewContext.save()
            } catch {
                self.viewContext.rollback()
                print(error)
            }
        }
    }
    
    func deleteAllPosts() {
        for post in getAllPosts() {
            viewContext.delete(post)
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
