//
//  PostInfo.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import Foundation

public struct PostInfoVM: Identifiable, Decodable {
    public let id: String
    public let username: String
    public let title: String
    public let likesAmount: Int
    public let commentsAmount: Int
    public let price: PriceVM
    public let isLiked: Bool
}

public struct PriceVM: Decodable {
    public let eur: Int
    public let usd: Int
    public let rub: Int
}

public struct PostDetailsVM: Decodable {
    public let description: String
    public let clothes: [ClothesElementVM]
}

public struct ClothesElementVM: Decodable {
    public let urlId: String
    public let brand: String
    public let description: String
    public let price: PriceVM
}

public struct PostImagesVM: Decodable {
    public let imageUrl: String
    public let postId: String
}

public struct PostVM: Decodable {
    public let postInfo: PostInfoVM
    public let images: [PostImagesVM]
}

class DataImport: ObservableObject {
    @Published var data = [PostInfoVM]()
    
    init() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: "https://swiracle.herokuapp.com/posts")!) { (data, _, _) in
            do {
                let fetch = try JSONDecoder().decode([PostVM].self, from: data!)
                
                DispatchQueue.main.async {
                    let post = fetch
                    var postInfo: [PostInfoVM] = []
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
