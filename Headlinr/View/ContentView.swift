//
//  ContentView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/1/25.

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel = ArticleViewModel()

    var body: some View {

        ScrollView {
            VStack{
                if let articles = viewModel.articles {
                    ForEach(articles,id:\.self) { article in
                        NewsRowView(article: article)
                    }
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
#Preview {
    ContentView()
}



