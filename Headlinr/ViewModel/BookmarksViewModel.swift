//
//  BookmarksViewModel.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/8/25.
//
import SwiftUI


class BookmarkViewModel: ObservableObject {
    @Published var savedArticles: [Article] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var error: String = ""

    init() {
        loadSavedArticles()
    }
  
    private func loadSavedArticles() {
        if let savedData = UserDefaults.standard.data(forKey: "SavedArticles"),
           let decoded = try? JSONDecoder().decode([Article].self, from: savedData) {
            self.savedArticles = decoded
        }
    }

    func saveArticle(_ article: Article) {
        if !savedArticles.contains(where: { $0.id == article.id }) {
            savedArticles.append(article)
            saveToUserDefaults()
        }
    }

    func removeArticle(_ article: Article) {
        savedArticles.removeAll { $0.id == article.id }
        saveToUserDefaults()
    }

    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(savedArticles) {
            UserDefaults.standard.set(encoded, forKey: "SavedArticles")
        }
    }
}
