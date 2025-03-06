//
//  NewsDetailView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/5/25.
//


import SwiftUI
import Kingfisher

struct NewsDetailView: View {
    let article: Article
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            VStack {
                Text( article.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .frame(maxWidth:.infinity,alignment: .leading)

                Text(article.publishedAt)
                    .font(.caption)
                    .frame(maxWidth:.infinity,alignment: .trailing)

            }
            .frame(maxWidth:.infinity)
      
            
            
            KFImage(URL(string: article.urlToImage ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth:.infinity)
                .frame(height: 200)
                .clipped()
                .cornerRadius(8)
             
            
          
            Text(article.content ?? "")
                .font(.callout)
            
            Spacer()
            
        }
        .padding(.all,12)

        
        
    }
}

