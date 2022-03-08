//
//  MovieServiceAPIRouter.swift
//  MVCChallenge
//
//  Created by Natália Brocca dos Santos on 04/03/22.
//

import Foundation

protocol APIRouterProtocol {
    var pathURL: URL? { get }
}

enum MovieServiceAPIRouter: APIRouterProtocol {
    case getPopular(page: Int)
    case getNowPlaying(page: Int)
    case getImage(poster_path: String)
    case getDetails(movieId: Int)
    
    private var baseURL: String {
        switch self {
        case .getPopular:
            return "https://api.themoviedb.org/3"
        case .getNowPlaying:
            return "https://api.themoviedb.org/3"
        case .getImage:
            return "https://image.tmdb.org/t/p/original"
        case .getDetails:
            return "https://api.themoviedb.org/3"
        }
    }
    
    private var apiKey: String {
        "67e15e91b36f5518c9415ec5db9ecddb"
    }
    
    var pathURL: URL? {
        switch self {
        case .getPopular(let page):
            return URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)&page=\(page)")
        case .getNowPlaying(let page):
            return URL(string: "\(baseURL)/movie/now_playing?api_key=\(apiKey)&page=\(page)")
        case .getImage(let poster_path):
            return URL(string: "\(baseURL)\(poster_path)")
        case .getDetails(let movieId):
            return URL(string: "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)")
        }
    }
}
