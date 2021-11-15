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
                Button(action: {
                    //TODO
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                    //TODO
                }) {
                    Text("For you")
                        .foregroundColor(.white)
                }
                Text("|")
                    .padding([.leading, .trailing], 8)
                    .foregroundColor(.gray)
                Button(action: {
                    //TODO
                }) {
                    Text("Following")
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    //TODO
                }) {
                    Image(systemName: "message.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
            }
            .padding()
            List (self.postsDB, id: \.id) { i in PostView(i) }
            .refreshable {
                CoreDataManager.shared.downloadAllPosts()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
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
                    Spacer(minLength: 10)
                    HStack {
                        Button(action: {
                            //TODO
                        }) {
                            HStack {
                                Image(systemName: "person.fill")
                                Text("@" + username)
                            }
                        }
                        Spacer()
                        Button(action: {
                            //TODO
                        }) {
                            Image(systemName: "ellipsis")
                        }
                    }
                    .padding([.leading, .trailing], 32)
                    ImagesView(images: images)
                    HStack {
                        Text(title)
                            .font(.system(size: 15))
                        Spacer()
                        Text(String(price) + " RUB")
                            .font(.system(size: 15))
                    }
                    .padding([.leading, .trailing], 32)
                    Spacer(minLength: 10)
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                Spacer()
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
    }
}

struct ImagesView: View {
    let images: [ImageDB]
    let imageWidth = UIScreen.main.bounds.size.width - 50
    let imageHeight = (UIScreen.main.bounds.size.width - 50) * (5/4)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(images, id: \.url) { i in
                    AnimatedImage(url: URL(string: i.url ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageWidth, height: imageHeight)
                        .clipped()
                }
            }
        }
        .frame(width: imageWidth, height: imageHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
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
