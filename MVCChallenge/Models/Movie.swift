//
//  Movie.swift
//  MVCChallenge
//
//  Created by Natália Brocca dos Santos on 07/03/22.
//

import Foundation

struct Movie: Codable, Hashable {
    var poster_path: String?
    var overview: String
    var genre_ids: [Int]
    var id: Int
    var title: String
    var vote_average: Double
}
