//
//  BookmarksView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/6/25.
//

import SwiftUI
import Kingfisher


struct BookmarkView: View {
    @ObservedObject var viewModel = BookmarkViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Saved Articles")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                List {
                    ForEach(viewModel.savedArticles) { article in
                        BookmarkRowView(article: article, viewModel: viewModel)
                    }
                }
       
                .listStyle(.plain)
            }
            
        }
    }
}


struct BookmarkRowView: View {
    let article: Article
    @ObservedObject var viewModel: BookmarkViewModel

    var body: some View {
        HStack {
           
            VStack(alignment: .leading, spacing: 5) {
                Text(article.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(article.description ?? "")
                    .font(.caption)

                HStack {
                  
                    Text(article.author ?? "CNN")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("• \(article.publishedAt)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: (UIScreen.main.bounds.width - 32)*0.6)
            
            VStack(spacing: 10){
                KFImage(URL(string: article.urlToImage ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
                    .frame(width: 140, height: 120)
                    .cornerRadius(8)
                // Bookmark Button
                HStack{
                    Button(action: {
                        viewModel.removeArticle(article)
                    }) {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.black)
                            .font(.callout)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .frame(width: (UIScreen.main.bounds.width - 32)*0.4)
        }
        .padding(.vertical, 8)
    }
}
