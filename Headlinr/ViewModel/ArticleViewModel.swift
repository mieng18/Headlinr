//
//  ArticleViewModel.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/3/25.
//


import SwiftUI
import Combine

@MainActor class ArticleViewModel: ObservableObject {
    @Published var articles: [Article]? = nil
    
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    let savedKey = "SavedArticles"
    


    private let  networkService = NetworkService.shared
    
    init() {
    }
    

    func fetchArticles() async throws {
        let articlesResponses: APIResponse = try await networkService.fetchData(client: NewsEndpoint.topHeadlines(country: "us"))
        
        self.articles = articlesResponses.articles
    }
    
    
    
    func refreshArticles() async {
          isLoading = true
          
          do {
               try await self.fetchArticles()
              // Fetch new articles from service
          } catch {
              // Handle errors
              errorMessage = "Failed to load articles: \(error.localizedDescription)"
              showError = true
          }
          
          isLoading = false
      }
    

}
