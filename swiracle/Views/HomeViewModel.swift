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
    let manager = CoreDataManager.shared
    
    func getAllPosts() {
        posts = manager.getAllPosts().map(PostViewModel.init)
    }
    
    func save() {
        manager.updateAllPosts()
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
