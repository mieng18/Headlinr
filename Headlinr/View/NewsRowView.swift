//
//  NewsRowView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/4/25.
//

import SwiftUI
import Kingfisher


struct NewsRowView: View {
    let article: Article
    
    var body: some View {
     
        HStack(spacing: 12) {
        
            
            KFImage(URL(string: article.urlToImage ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(8)
             
            
            
                VStack(alignment: .leading, spacing: 8) {
                    titleView
                    descriptionView
                }
                
                .padding(.vertical, 12)
                .padding(.trailing, 12)
           
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color(.systemGray5), radius: 2, x: 0, y: 1)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
    
    // MARK: - Component Views
    
    private var articleImageView: some View {
        AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
            case .failure:
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 100)
                    .background(Color(.systemGray6))
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 100)
                    .background(Color(.systemGray6))
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private var titleView: some View {
        Text(article.title)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .lineLimit(2)
    }
    
    private var descriptionView: some View {
        Text(article.description ?? "No description available")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
   
}

