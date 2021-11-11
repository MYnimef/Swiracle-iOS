//
//  HomeView.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(entity: Post.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Post.id, ascending: false)])
    var postsDB: FetchedResults<Post>
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().backgroundColor = UIColor(named: "BackgroundColor")
        
        CoreDataManager.shared.downloadAllPosts()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("For you")
                Text("Following")
            }
            .padding()
            List (self.postsDB, id: \.id) { i in PostView(i) }
            .refreshable {
                CoreDataManager.shared.downloadAllPosts()
            }
            .cornerRadius(10)
        }
    }
}

struct PostView: View {
    let username: String
    let title: String
    let price: Int
    let likesAmount: Int
    let commentsAmount: Int
    var images: [ImageDB]
    
    init(_ post: Post) {
        username = post.username ?? ""
        title = post.title ?? ""
        price = Int(post.price)
        likesAmount = Int(post.likesAmount)
        commentsAmount = Int(post.commentsAmount)
        
        images = CoreDataManager.shared.getPostImages(post)
    }
    
    var body: some View {
        Section {
            VStack {
                HStack {
                    Text(username)
                }
                HStack {
                    ForEach(images, id: \.url) { i in
                        /*
                        AsyncImage(url: URL(string: i.url ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                         */
                    }
                }
                HStack {
                    Text(title)
                    Text(String(price))
                }
                HStack {
                    Text(String(likesAmount))
                    Text(String(commentsAmount))
                }
            }
        }
        .listRowBackground(Color.white)
        .foregroundColor(.black)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
