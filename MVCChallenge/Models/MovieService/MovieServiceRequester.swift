//
//  MovieServiceRequester.swift
//  MVCChallenge
//
//  Created by Natália Brocca dos Santos on 07/03/22.
//

import Foundation

protocol RequesterProtocol {
    func request<T: Decodable>(apiRouter: APIRouterProtocol, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}

class Requester: RequesterProtocol {
    
    let parser: ParserProtocol
    
    init(parser: ParserProtocol = Parser()) {
        self.parser = parser
    }
    
    func request<T: Decodable>(apiRouter: APIRouterProtocol, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = apiRouter.pathURL else {
            completionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(.unknownError))
                return
            }
            guard let parsedObject: T = self.parser.parse(data: data) else {
                completionHandler(.failure(.unknownError))
                return
            }
            completionHandler(.success(parsedObject))
        }
        .resume()
    }
}
