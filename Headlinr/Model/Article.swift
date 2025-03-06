//
//  Article.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/3/25.
//



import Foundation

// MARK: - Main Response Model
struct APIResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article Model
struct Article: Codable,Identifiable {
    let id = UUID()  // Assigns a unique ID to each article
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

// MARK: - Source Model
struct Source: Codable,Hashable,Identifiable {
    let id: String?
    let name: String
}
