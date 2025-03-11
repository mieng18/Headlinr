//
//  NewsViewModel.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/10/25.
//


import SwiftUI
import Combine

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    private let networkService: NetworkService
    private var currentPage = 1
    private let pageSize = 20
    private var hasMorePages = true

    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }

    /// Fetch Regular News Articles
    func fetchNewsArticles(isRefreshing: Bool = false) async {
        guard !isLoading, hasMorePages else { return }

        isLoading = true

        if isRefreshing {
            currentPage = 1
            hasMorePages = true
            articles.removeAll()
        }

        do {
            let response: APIResponse = try await networkService.fetchData(
                client: NewsEndpoint.everything(query: "everything", page: currentPage, pageSize: pageSize)
            )

            if isRefreshing {
                articles = response.articles
            } else {
                articles.append(contentsOf: response.articles)
            }

            hasMorePages = response.articles.count == pageSize
            currentPage += 1
        } catch {
            errorMessage = "Failed to load news articles: \(error.localizedDescription)"
            showError = true
        }

        isLoading = false
    }

    /// Detect when to load more news articles
    func loadMoreNewsIfNeeded(currentArticle: Article) {
        guard let lastArticle = articles.last, lastArticle.id == currentArticle.id else { return }

        Task {
            await fetchNewsArticles()
        }
    }

    /// Refresh and reset news articles
    func refreshNewsArticles() async {
        await fetchNewsArticles(isRefreshing: true)
    }
}
