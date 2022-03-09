//
//  LoadData.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 09/03/22.
//

import Foundation

protocol LoadDataProtocol {
    func loadNowPlayingMovies()
    func loadPopularMovies()
}

extension LoadDataProtocol {
    func loadMovies() {
        loadNowPlayingMovies()
        loadPopularMovies()
    }
}
