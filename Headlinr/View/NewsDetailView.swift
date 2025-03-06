//
//  NewsDetailView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/5/25.
//


import SwiftUI
import Kingfisher
import SafariServices


struct NewsDetailView: View {
    let article: Article
    @State private var showWebView = false

    
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
            
            if let url = URL(string: article.url) {
              Button(action: {
                  showWebView = true  // Show in-app browser
              }) {
                  Text("Continue reading")
                      .font(.subheadline)
                      .fontWeight(.semibold)
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity)
                      .padding(.all,12)
                      .background(Color.blue.opacity(0.9))
                      .cornerRadius(12)
                  
              }
              .padding(.top, 10)
              .sheet(isPresented: $showWebView) {
                  // Opens in-app Safari
                  SafariView(url: url)
              }
          }

            
            Spacer()
            
        }
        .padding(.all,12)
    }
}



