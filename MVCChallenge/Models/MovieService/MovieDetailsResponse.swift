//
//  MovieDetailsResponse.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 08/03/22.
//

import Foundation

class MovieDetailsResponse: Codable {
    var overview: String
    var original_title: String
    var genres: [String]
    var popularity: Double
}
