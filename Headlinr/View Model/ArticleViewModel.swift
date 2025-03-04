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
    
    private let  networkService = NetworkService.shared
    
    func fetchArticles() async throws {
        let articlesResponses: APIResponse = try await networkService.fetchData(client: NewsEndpoint.search(value: "us"))
        
        self.articles = articlesResponses.articles
    }
    

}
