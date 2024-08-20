//
//  TMainabBarView.swift
//  SparTask
//
//  Created by Диас Сайынов on 19.08.2024.
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            FavouritesView()
                .tabItem { 
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                }
        }
    }
}

#Preview {
    MainTabBarView()
}
