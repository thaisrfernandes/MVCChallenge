//
//  MoviesResponse.swift
//  MVCChallenge
//
//  Created by Natália Brocca dos Santos on 07/03/22.
//

import Foundation

struct MoviesResponse: Codable {
    var page: Int
    var results: [Movie]
    var total_results: Int
    var total_pages: Int
}

