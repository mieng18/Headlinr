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
struct Article: Codable,Hashable {
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
struct Source: Codable,Hashable {
    let id: String?
    let name: String
}
