//
//  MovieServiceParser.swift
//  MVCChallenge
//
//  Created by Natália Brocca dos Santos on 07/03/22.
//

import Foundation

protocol ParserProtocol {
    func parse<T: Decodable>(data: Data) -> T?
}

class Parser: ParserProtocol {
    func parse<T: Decodable>(data: Data) -> T? {
        do {
            let parsed = try JSONDecoder().decode(T.self, from: data)
            return parsed
        } catch {
            print(error)
            return nil
        }
    }
}
