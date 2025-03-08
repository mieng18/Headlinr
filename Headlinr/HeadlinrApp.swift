//
//  HeadlinrApp.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/1/25.
//

import SwiftUI

@main
struct HeadlinrApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


struct ContentView: View {
    
    @State private var activeTab: TabItem = .home

    var body: some View {

        ZStack(alignment: .bottom) {
            Group {
                if #available(iOS 18.0, *) {
                    TabView(selection: $activeTab) {
                        Tab.init(value: .home) {
                            Home()
                        }
                        
                        Tab.init(value: .bookmarks) {
                            BookmarkView()
                        }
                        
                        Tab.init(value: .profile) {
                            ProfileView()
                        }
                    }
                    
                } else {
                    TabView(selection: $activeTab) {
                        ContentView()
                            .tag(TabItem.home)
                           
                        BookmarkView()
                            .tag(TabItem.bookmarks)
                        
             
                        ProfileView()
                            .tag(TabItem.profile)
                    }
                }
            }
            
            CustomTabBarView(selectedTab: $activeTab)
        }
    }
}
