//
//  PostInfo.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import Foundation

public struct PostInfoJSON: Identifiable, Decodable {
    public let id: String
    public let username: String
    public let title: String
    public let likesAmount: Int
    public let commentsAmount: Int
    public let price: PriceJSON
    public let isLiked: Bool
}

public struct PriceJSON: Decodable {
    public let eur: Int
    public let usd: Int
    public let rub: Int
}

public struct PostDetailsJSON: Decodable {
    public let description: String
    public let clothes: [ClothesElementJSON]
}

public struct ClothesElementJSON: Decodable {
    public let urlId: String
    public let brand: String
    public let description: String
    public let price: PriceJSON
}

public struct PostImagesJSON: Decodable {
    public let imageUrl: String
    public let postId: String
}

public struct PostJSON: Decodable {
    public let postInfo: PostInfoJSON
    public let images: [PostImagesJSON]
}

class PostsGetter {
    func download() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: "https://swiracle.herokuapp.com/posts")!) { (data, _, _) in
            do {
                let fetch = try JSONDecoder().decode([PostJSON].self, from: data!)
                
                DispatchQueue.main.async {
                    CoreDataManager.shared.updateAllPosts(data: fetch)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
