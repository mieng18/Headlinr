//
//  BookmarksViewModel.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/8/25.
//
import SwiftUI


class BookmarkViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var error: String = ""

    init() {
        loadSavedArticles()
    }

  
    private func loadSavedArticles() {
        if let savedData = UserDefaults.standard.data(forKey: "SavedArticles"),
           let decoded = try? JSONDecoder().decode([Article].self, from: savedData) {
            self.articles = decoded
        }
    }

    func saveArticle(_ article: Article) {
        if !articles.contains(where: { $0.id == article.id }) {
            articles.append(article)
            saveToUserDefaults()
        }
    }

    func removeArticle(_ article: Article) {
        articles.removeAll { $0.id == article.id }
        saveToUserDefaults()
    }

    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(encoded, forKey: "SavedArticles")
        }
    }
}
