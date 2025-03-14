//
//  HeadlinrConstants.swift.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/8/25.
//


import Foundation
import UIKit


struct HeadlinrConstants {
    static let baseURL = "https://newsapi.org"
    static var apiKey: String {
          return Bundle.main.object(forInfoDictionaryKey: "NewsAPIKey") as? String ?? "MISSING_API_KEY"
      }
    struct Paths {
          static let topHeadlines = "/v2/top-headlines"
          static let everything = "/v2/everything"
          static let sources = "/v2/sources"
      }
  }


struct Constants {
    static let screenWidth = UIScreen.main.bounds.width
    static let itemWidth = (screenWidth / 2) + 10
}
