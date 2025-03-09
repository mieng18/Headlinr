//
//  NewsEndpoint.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/3/25.
//


import Foundation

enum NewsEndpoint{
    case topHeadlines(country: String)
    case everything(query: String, page: Int, pageSize: Int)
    case categoryNews(category: String, country: String)
    
}

extension NewsEndpoint: EndpointProtocol {

    var baseURL: String {
        return HeadlinrConstants.baseURL
    }


    var path: String {
        switch self {
        case .topHeadlines:
            return HeadlinrConstants.Paths.topHeadlines
        case .everything:
            return HeadlinrConstants.Paths.everything
        case .categoryNews:
            return HeadlinrConstants.Paths.sources
        }
    }

    var parameter:  [URLQueryItem] {
        switch self {
        case .topHeadlines(let country):
            return [
                URLQueryItem(name: "country", value: country),
                URLQueryItem(name: "apiKey", value: HeadlinrConstants.apiKey)
            ]

        case .everything(let query, let page, let pageSize):
            return [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "pageSize", value: "\(pageSize)"),
                URLQueryItem(name: "apiKey", value: HeadlinrConstants.apiKey)
            ]

        case .categoryNews(let category, let country):
            return [
                URLQueryItem(name: "category", value: category),
                URLQueryItem(name: "country", value: country),
                URLQueryItem(name: "apiKey", value:  HeadlinrConstants.apiKey)
            ]
        }
    }

    var request: URLRequest? {
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.path = path
        urlComponent?.queryItems = parameter
        
        if let urlString = urlComponent?.url {
            var request = URLRequest(url: urlString)
            request.httpMethod = httpMethod.rawValue
            request.allHTTPHeaderFields = header
            return request
            
        }
        
        return nil
     
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var header: [String : String] {
        return ["Content-Type":"application/json"]
    }

}

