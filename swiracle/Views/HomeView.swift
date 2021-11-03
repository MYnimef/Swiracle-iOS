//
//  HomeView.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var getData = DataImport()
    
    var body: some View {
        VStack {
            HStack {
                Text("For you")
                Text("Following")
            }
            .padding()
            List(getData.data) { i in PostView(
                username: i.username,
                title: i.title,
                price: i.price.rub,
                likesAmount: i.likesAmount,
                commentsAmount: i.commentsAmount)
            }
            .padding()
        }
    }
}

struct PostView: View {
    let username: String
    let title: String
    let price: Int
    let likesAmount: Int
    let commentsAmount: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(username)
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
