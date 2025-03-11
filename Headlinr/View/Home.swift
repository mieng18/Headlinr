//
//  ContentView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/1/25.

import SwiftUI
import Kingfisher


struct Home: View {
    
    @StateObject var viewModel = NewsViewModel()
    @StateObject var bookmarkViewModel = BookmarkViewModel()
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showSearchView = false
     
    var body: some View {
        
        NavigationStack {

            ZStack{
                
                VStack(spacing:0) {
                    HStack {
                        Image("Headlinr-clear")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 40)
                            .padding(.leading,12)
                        
                        Spacer()
                        
                    }
                    
                    CustomSearchBar(searchText: $searchText)
                    ScrollView {
                        VStack{
                            
                            TopHeadlinesView()
                            
                        
                            
                            ListView()
                        }
                    }
                    
                }
            }
            
        }
    }
}

#Preview {
    Home()
}

