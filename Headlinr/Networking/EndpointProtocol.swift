//
//  EndpointProtocol.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/3/25.
//


import Foundation



enum HTTPMethod: String {
    case get =  "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}


protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var parameter: [URLQueryItem] {get}
    var request: URLRequest? {get}
    var httpMethod: HTTPMethod {get}
    var header: [String : String] {get}
}

