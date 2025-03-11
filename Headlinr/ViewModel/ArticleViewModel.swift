//
//  ArticleViewModel.swift
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

    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }

    /// Fetch Spotlight Articles (Top Headlines)
    func fetchSpotlightArticles(isRefreshing: Bool = false) async {
        guard !isLoading, hasMorePages else { return }

        isLoading = true

        if isRefreshing {
            currentPage = 1
            hasMorePages = true
            articles.removeAll()
        }

        do {
            let response: APIResponse = try await networkService.fetchData(
                client: NewsEndpoint.topHeadlines(country: "us", page: currentPage, pageSize: pageSize)
            )

            if isRefreshing {
                articles = response.articles
            } else {
                articles.append(contentsOf: response.articles)
            }

            hasMorePages = response.articles.count == pageSize
            currentPage += 1
        } catch {
            errorMessage = "Failed to load spotlight articles: \(error.localizedDescription)"
            showError = true
        }

        isLoading = false
    }

    /// Detect when to load more spotlight articles
    func loadMoreSpotlightIfNeeded(currentArticle: Article) {
        guard let lastArticle = articles.last, lastArticle.id == currentArticle.id else { return }

        Task {
            await fetchSpotlightArticles()
        }
    }

    /// Refresh and reset spotlight articles
    func refreshSpotlightArticles() async {
        await fetchSpotlightArticles(isRefreshing: true)
    }
}
