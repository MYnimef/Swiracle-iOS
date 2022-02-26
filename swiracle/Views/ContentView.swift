//
//  ContentView.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import SwiftUI


struct ContentView: View {
    
    init() {
        //UITabBar.appearance().barTintColor = .black
        //UITabBar.appearance().tintColor = .blue
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().isTranslucent = false
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(NSLocalizedString("Home", comment: ""))
                }
            PopularView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text(NSLocalizedString("Popular", comment: ""))
                }
            CreateView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text(NSLocalizedString("Create", comment: ""))
                }
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text(NSLocalizedString("Notifications", comment: ""))
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text(NSLocalizedString("Profile", comment: ""))
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
