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
    @Published var savedArticles: [Article] = [] // Stores saved articles
    let savedKey = "SavedArticles"
    


    private let  networkService = NetworkService.shared
    
    init() {
        loadSavedArticles()
    }
    
    func saveArticle(_ article: Article) {
          if !savedArticles.contains(where: { $0.url == article.url }) {
              savedArticles.append(article)
              saveToUserDefaults()
          }
      }
    
    func removeArticle(_ article: Article) {
        savedArticles.removeAll { $0.url == article.url }
         saveToUserDefaults()
     }

    private func saveToUserDefaults() {
          if let encoded = try? JSONEncoder().encode(savedArticles) {
              UserDefaults.standard.set(encoded, forKey: savedKey)
          }
      }

      // Load saved articles from UserDefaults
      private func loadSavedArticles() {
          if let savedData = UserDefaults.standard.data(forKey: savedKey),
             let decoded = try? JSONDecoder().decode([Article].self, from: savedData) {
              savedArticles = decoded
          }
      }
     
    func fetchArticles() async throws {
        let articlesResponses: APIResponse = try await networkService.fetchData(client: NewsEndpoint.search(value: "us"))
        
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
