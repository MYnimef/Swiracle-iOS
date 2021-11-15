//
//  HomeView.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @FetchRequest(entity: Post.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Post.id, ascending: false)])
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
    let id: String
    let username: String
    let title: String
    let price: Int
    let likesAmount: Int
    let commentsAmount: Int
    let images: [ImageDB]
    
    init(_ post: Post) {
        id = post.id ?? ""
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
                VStack {
                    HStack {
                        Text("@" + username)
                    }
                    ImagesView(images: images)

                    HStack {
                        Text(title)
                        Text(String(price))
                    }
                }
                .background(Color.white)
                .cornerRadius(32)
                BottomButtonsView(
                    id: id,
                    likesAmount: likesAmount,
                    commentsAmount: commentsAmount
                )
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color(UIColor(named: "BackgroundColor")!))
        .foregroundColor(.black)
        //.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct ImagesView: View {
    let images: [ImageDB]
    
    var body: some View {
        HStack {
            ForEach(images, id: \.url) { i in
                AnimatedImage(url: URL(string: i.url ?? ""))
                    .resizable()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
            .padding([.leading, .trailing], 10)
        }
        .frame(height: (UIScreen.main.bounds.size.width - 40) * (5/4))
    }
}

struct BottomButtonsView: View {
    let id: String
    let likesAmount: Int
    let commentsAmount: Int
    
    let iconSize: CGFloat = 24
    
    var body: some View {
        HStack {
            Button(action: {
                //TODO
            }) {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
            }
            Text(String(likesAmount))
            Spacer()
            Button(action: {
                //TODO
            }) {
                Image(systemName: "bubble.left")
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
            }
            Text(String(commentsAmount))
            Spacer()
            Spacer()
            Button(action: {
                //TODO
            }) {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
            }
        }
        .padding([.leading, .trailing], 20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
