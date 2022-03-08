//
//  RequesterTests.swift
//  MVCChallengeTests
//
//  Created by Natália Brocca dos Santos on 07/03/22.
//

import XCTest

class RequesterTests: XCTestCase {

    func test_requester_request_withSuccess() throws {
        let sut = Requester()
        let apiRouter = APIRouterFake(url: Bundle(for: type(of: self)).url(forResource: "MovieMock", withExtension: "json"))
        let expectation = XCTestExpectation(description: #function)
        var movieResponse: MoviesResponse? = nil
        
        sut.request(apiRouter: apiRouter) { (result: Result<MoviesResponse, NetworkError>) in
            switch result {
            case .success(let mvResponse):
                movieResponse = mvResponse
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(movieResponse)
    }
    
    func test_requester_request_withFailure() throws {
        let sut = Requester()
        let apiRouter = APIRouterFake(url: URL(string: ""))
        
        sut.request(apiRouter: apiRouter) { (result: Result<MoviesResponse, NetworkError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

}

class APIRouterFake: APIRouterProtocol {
    
    var pathURL: URL?
    
    init(url: URL?) {
        self.pathURL = url
    }
}


