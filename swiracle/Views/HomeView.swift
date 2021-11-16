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
    
    @State var showPost = false
    @State var showProfile = false
    
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
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                    //TODO
                }) {
                    Text("Following")
                        .foregroundColor(.gray)
                }
                Text("|")
                    .padding([.leading, .trailing], 8)
                    .foregroundColor(.gray)
                Button(action: {
                    //TODO
                }) {
                    Text("For you")
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                    //TODO
                }) {
                    Image(systemName: "message.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            }
            .padding([.leading, .trailing], 32)
            .padding(.top, 10)
            List (self.postsDB, id: \.id) { i in
                PostViewRow(i, showPostView, showProfileView)
            }
            .refreshable {
                CoreDataManager.shared.downloadAllPosts()
            }
            .sheet(isPresented: $showPost) {
                PostView()
            }
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
    
    func showPostView() {
        showPost.toggle()
    }
    
    func showProfileView() {
        showProfile.toggle()
    }
}

struct PostViewRow: View {
    let id: String
    let username: String
    let title: String
    let price: Int
    let isLiked: Bool = false
    let likesAmount: Int
    let commentsAmount: Int
    let images: [ImageDB]
    
    let showPost: () -> ()
    let showProfile: () -> ()
    
    init(_ post: Post, _ showPost: @escaping () -> (), _ showProfile: @escaping () -> ()) {
        id = post.id ?? ""
        username = post.username ?? ""
        title = post.title ?? ""
        price = Int(post.price)
        likesAmount = Int(post.likesAmount)
        commentsAmount = Int(post.commentsAmount)
        images = CoreDataManager.shared.getPostImages(post)
        
        self.showPost = showPost
        self.showProfile = showProfile
    }
    
    var body: some View {
        Section {
            VStack {
                VStack {
                    Spacer(minLength: 16)
                    HStack {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("@" + username)
                            Spacer()
                        }
                        .onTapGesture {
                            showProfile()
                        }
                        Image(systemName: "ellipsis")
                            .onTapGesture {
                                //TODO
                            }
                    }
                    .padding([.leading, .trailing], 32)
                    Spacer(minLength: 16)
                    VStack {
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
                    .onTapGesture {
                        showPost()
                    }
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                Spacer(minLength: 16)
                BottomButtonsView(
                    id: id,
                    isLiked: isLiked,
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
    @State var isLiked: Bool
    let likesAmount: Int
    let commentsAmount: Int
    
    let iconSize: CGFloat = 24
    
    var body: some View {
        HStack {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize, height: iconSize)
                .onTapGesture {
                    isLiked.toggle()
                }
            Text(String(likesAmount))
            Spacer()
            Button(action: {
                //TODO
            }) {
                Image(systemName: "bubble.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
                    .aspectRatio(contentMode: .fit)
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
