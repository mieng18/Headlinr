//
//  CustomTabBarView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/8/25.
//



import SwiftUI

enum TabItem: String, CaseIterable {
    case home
    case discovery
    case bookmarks
    case profile

    var tabIcon: String {
        switch self {
        case .home:
            return "house.fill"
        case .discovery:
            return "bookmark.fill"
        case .bookmarks:
            return "bookmark.fill"
        case .profile:
            return "person.fill"
        }
    }

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .discovery:
            return "Explore"
        case .bookmarks:
            return "Bookmarks"
        case .profile:
            return "Profile"
        }
    }
}


struct CustomTabBarView: View {
    @Binding var selectedTab: TabItem

    var body: some View {
        HStack {
            ForEach(TabItem.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing:5) {
                        Image(systemName: tab.tabIcon)
                            .font(.system(size: 22, weight: .medium))
                        Text(tab.title)
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == tab ? .black : .gray)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
