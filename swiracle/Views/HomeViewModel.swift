//
//  HomeViewModel.swift
//  Swiracle
//
//  Created by Ivan Markov on 09.11.2021.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var posts: [PostViewModel] = []
    @ObservedObject var network = DataImport()
    
    func getAllPosts() {
        posts = CoreDataManager.shared.getAllPosts().map(PostViewModel.init)
    }
    
    func save() {
        CoreDataManager.shared.deleteAllPosts()
        
        var posts = [Post]()
        for i in network.data {
            let post = Post(context: CoreDataManager.shared.viewContext)
            post.id = i.id
            post.username = i.username
            post.title = i.title
            post.price = Int64(i.price.rub)
            post.likesAmount = Int64(i.likesAmount)
            post.commentsAmount = Int64(i.commentsAmount)
            post.isLiked = false
            
            posts.append(post)
        }
            
        CoreDataManager.shared.save()
    }
}

struct PostViewModel: Identifiable {
    let post: Post
    
    var id: String {
        return post.id ?? ""
    }
    
    var username: String {
        return post.username ?? ""
    }
    
    var title: String {
        return post.title ?? ""
    }
    
    var price: Int {
        return Int(post.price)
    }
    
    var isLiked: Bool {
        return post.isLiked
    }
    
    var likesAmount: Int {
        return Int(post.likesAmount)
    }
    
    var commentsAmount: Int {
        return Int(post.commentsAmount)
    }
}
