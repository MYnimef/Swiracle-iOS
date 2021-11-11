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
    
    func updateAllPosts(data: [PostJSON]) {
        self.deleteAllPosts()
            
        for i in data {
            let post = Post(context: self.viewContext)
            post.id = i.postInfo.id
            post.username = i.postInfo.username
            post.title = i.postInfo.title
            post.price = Int64(i.postInfo.price.rub)
            post.likesAmount = Int64(i.postInfo.likesAmount)
            post.commentsAmount = Int64(i.postInfo.commentsAmount)
            post.isLiked = false
            
            for image in i.images {
                let imageDB = ImageDB(context: self.viewContext)
                imageDB.url = image.imageUrl
                post.addToImages(imageDB)
            }
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
    
    func getPostImages(_ post: Post) -> [ImageDB] {
        let request: NSFetchRequest<ImageDB> = ImageDB.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ImageDB.post), post)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
