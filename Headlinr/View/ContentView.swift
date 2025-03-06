//
//  ContentView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/1/25.

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel = ArticleViewModel()

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
                    
                    ScrollView {
                        VStack{
                            if let articles = viewModel.articles {
                                ForEach(articles,id:\.self) { article in
                                    
                                    NavigationLink(destination: NewsDetailView(article: article)) {
                                        NewsRowView(article: article)

                                    }
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
        }
    }
}
#Preview {
    ContentView()
}



