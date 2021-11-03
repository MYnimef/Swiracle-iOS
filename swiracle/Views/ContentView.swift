//
//  ContentView.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            PopularView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Popular")
                }
            CreateView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Create")
                }
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct CreateView: View {
    var body: some View {
        VStack {
            Text("Create")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
