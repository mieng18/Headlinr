//
//  SpotlightViewModel.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/3/25.
//


import SwiftUI
import Combine


@MainActor
class SpotlightViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    private let networkService: NetworkService
    private var currentPage = 1
    private let pageSize = 10
    private var hasMorePages = true
    private var totalResults = 0

    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }

    /// Fetch Spotlight Articles (Top Headlines)
    func fetchSpotlightArticles(isRefreshing: Bool = false) async {
        guard !isLoading, hasMorePages else { return }
        
        defer {
            isLoading = false
        }
        
        isLoading = true

        if isRefreshing {
            currentPage = 1
            hasMorePages = true
            totalResults = 0
            articles.removeAll()
        }

        do {
            let response: APIResponse = try await networkService.fetchData(
                client: NewsEndpoint.topHeadlines(country: "us", page: currentPage, pageSize: pageSize)
            )
            
            // Store total results for better pagination handling
            totalResults = response.totalResults
            
            // Handle empty results
            if response.articles.isEmpty {
                hasMorePages = false
            } else {
                if isRefreshing {
                    articles = response.articles
                } else {
                    articles.append(contentsOf: response.articles)
                }
                
                // Check if we've reached the end
                hasMorePages = articles.count < totalResults && response.articles.count == pageSize
                currentPage += 1
            }
        } catch {
            errorMessage = "Failed to load spotlight articles: \(error.localizedDescription)"
            showError = true
        }
    }

    /// Detect when to load more spotlight articles
    func loadMoreSpotlightIfNeeded(currentArticle: Article) {
        guard hasMorePages, !isLoading else { return }
        
        // Check if we're near the end of the list (last 3 items)
        let thresholdIndex = articles.index(articles.endIndex, offsetBy: -3)
        if let currentIndex = articles.firstIndex(where: { $0.id == currentArticle.id }),
           currentIndex >= thresholdIndex {
            Task {
                await fetchSpotlightArticles()
            }
        }
    }

    /// Refresh and reset spotlight articles
    func refreshSpotlightArticles() async {
        await fetchSpotlightArticles(isRefreshing: true)
    }
    
    /// Cancel any ongoing requests
    func cancelRequests() {
    }
}
