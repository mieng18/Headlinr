//
//  ContentView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/1/25.

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel = ArticleViewModel()
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showSearchView = false
    
    var filteredArticles: [Article] {
        guard let articles = viewModel.articles else { return [] }

        if searchText.isEmpty {
            return articles
        } else {
            return articles.filter { article in
                article.title.lowercased().contains(searchText.lowercased()) ||
                (article.description ?? "").lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {

        NavigationView {
            
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
                        VStack(spacing: 12) {
                            ForEach(filteredArticles) { article in
                                NavigationLink(destination: NewsDetailView(article: article)) {
                                     NewsRowView(article: article)
                                 }
                                 .buttonStyle(PlainButtonStyle())
                             }
                         }

                        .onAppear {
                            Task {
                                do {
                                    try await viewModel.fetchArticles()
                                    
                                } catch {
                                    print("Can not fetchg aritcles")
                                }
                            }
                        }
                    }
                    
                }
                
            }
        }
    }
    
    
    
}
#Preview {
    ContentView()
}


