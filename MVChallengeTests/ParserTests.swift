//
//  ParserTests.swift
//  MVCChallengeTests
//
//  Created by Natália Brocca dos Santos on 07/03/22.
//

import XCTest

class ParserTests: XCTestCase {

    func test_parse_withSuccess() throws {
        let sut = Parser()
        let testMovie = Movie(poster_path: "test", overview: "test", genre_ids: [], id: 23, title: "test", vote_average: 0)
        guard let data = try? JSONEncoder().encode(testMovie) else {
            XCTFail()
            return
        }
        
        guard let returnedMovie: Movie = sut.parse(data: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(testMovie.id, returnedMovie.id)
    }
    
    func test_parse_withFailure() throws {
        let sut = Parser()
        let data = Data()
        
        let returnedMovie: Movie? = sut.parse(data: data)
        XCTAssertNil(returnedMovie)
    }
}
