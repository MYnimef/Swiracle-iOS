//
//  PostInfo.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import Foundation

public struct PostInfo: Identifiable, Decodable {
    public let id: String
    public let username: String
    public let title: String
    public let likesAmount: Int
    public let commentsAmount: Int
    public let price: Price
    public let isLiked: Bool
}

public struct Price: Decodable {
    public let eur: Int
    public let usd: Int
    public let rub: Int
}

public struct PostDetails: Decodable {
    public let description: String
    public let clothes: [ClothesElement]
}

public struct ClothesElement: Decodable {
    public let urlId: String
    public let brand: String
    public let description: String
    public let price: Price
}

public struct PostImages: Decodable {
    public let imageUrl: String
    public let postId: String
}

public struct Post: Decodable {
    public let postInfo: PostInfo
    public let images: [PostImages]
}

class DataImport : ObservableObject {
    @Published var data = [PostInfo]()
    
    init() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: "https://swiracle.herokuapp.com/posts")!) { (data, _, _) in
            do {
                let fetch = try JSONDecoder().decode([Post].self, from: data!)
                
                DispatchQueue.main.async {
                    let post = fetch
                    var postInfo: [PostInfo] = []
                    for i in post {
                        postInfo.append(i.postInfo)
                    }
                    self.data = postInfo
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
