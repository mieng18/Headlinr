//
//  TopHeadlinesView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/8/25.
//


import SwiftUI
import Kingfisher


struct TopHeadlinesView: View {
    @StateObject var viewModel = SpotlightViewModel()
    
    @State private var showMore = false

    
//    var filteredArticles: [Article] {
//          guard let articles = viewModel.articles else { return [] }
//  
//          return articles
//      }
//  
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                Text("Today’s Spotlight")
                    .font(.title2)
                    .bold()

                Spacer()

                NavigationLink(destination: TopHeadlinesListView()) {
                    Text("See all")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(
                            Capsule()
                                .stroke(lineWidth: 1.5)
                                .foregroundColor(.gray.opacity(0.2))
                        )
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.articles.prefix(10)) { article in
                        NavigationLink(destination: NewsDetailView(article: article)) {
                            TopHeadlineCardView(article: article)
                        }
                    }
                    .background(.white)
                }
                .padding(.horizontal)
                
            }
            .frame(height: 250)
            
                
        }
        
        .onAppear {
            Task {
                do  {
                    try await viewModel.fetchSpotlightArticles()

                    
                    
                } catch {
                    
                    print("Fail to fetch articles")
                    
                }
            }
            
        }
    }
}

#Preview {
    TopHeadlinesView()
}


struct TopHeadlineCardView: View {
    let article: Article

    var body: some View {
        
        
        VStack(spacing: 8) {
  
            
            KFImage(URL(string: article.urlToImage ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Constants.itemWidth, height: 120)
                .clipped()
                .cornerRadius(10)
            
            Text(article.title)
                .foregroundColor(.black)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            HStack{
                
                Text(article.source.name ?? "Unknown Source")
                    .font(.caption)

                Spacer()
                
                HStack(spacing:3){
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width:10, height: 10)
                        .font(.caption)
                               
                    Text(article.publishedAt.timeAgoDisplay())
                        .font(.caption)
                }

            }
            .foregroundColor(.gray)

        }
        .frame(width: Constants.itemWidth, height: 230)
        .background(Color.white)
        .cornerRadius(12)
        
    }
}
extension String {
    func timeAgoDisplay() -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: self) else { return self }

        let timeInterval = Date().timeIntervalSince(date)
        let minutes = Int(timeInterval) / 60
        let hours = minutes / 60
        let days = hours / 24

        if minutes < 60 {
            return "\(minutes) min ago"
        } else if hours < 24 {
            return "\(hours) hours ago"
        } else {
            return "\(days) days ago"
        }
    }
}


struct TopHeadlinesListView: View {
    
    @ObservedObject var viewModel =  SpotlightViewModel()
    @StateObject var bookmarkViewModel = BookmarkViewModel()
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showSearchView = false
    
    
    var filteredArticles: [Article] {

        if searchText.isEmpty {
            return viewModel.articles
        } else {
            return viewModel.articles.filter { article in
                article.title.lowercased().contains(searchText.lowercased()) ||
                (article.description ?? "").lowercased().contains(searchText.lowercased())
            }
        }
    }

    
    var body: some View {
            
    
                VStack(spacing: 12) {
                    ForEach(filteredArticles) { article in
                        NavigationLink(destination: NewsDetailView(article: article)) {
                            NewsRowView(article: article, bookmarkViewModel: bookmarkViewModel)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                .onAppear {
                    Task {
                        do {
                            try await viewModel.fetchSpotlightArticles()
                            
                        } catch {
                            print("Can not fetchg aritcles")
                        }
                    }
                }
        }
}


struct ListView: View {
    
    @ObservedObject var viewModel = NewsViewModel()
    @StateObject var bookmarkViewModel = BookmarkViewModel()


    var body: some View {
        
    
        VStack(spacing: 12) {
            ForEach(viewModel.articles) { article in
                NavigationLink(destination: NewsDetailView(article: article)) {
                        NewsRowView(article: article, bookmarkViewModel: bookmarkViewModel)
                    
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchNewsArticles()

                } catch {
                    print("Can not fetch")
                }
            }
        }
    }
}



