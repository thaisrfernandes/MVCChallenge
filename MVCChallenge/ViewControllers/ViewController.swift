//
//  ViewController.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 04/03/22.
//

import UIKit

class ViewController: UIViewController {
    var coordinator: MainCoordinator?
    var requester = Requester()
    
    var nowPlayingMovies = [Movie]()
    var popularMovies = [Movie]()

    private lazy var navButton = { return UIButton(frame: .zero) }()
    private lazy var apiButton = { return UIButton(frame: .zero) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        applyViewCode()
    }
    
    @objc func buttonAction(sender: UIButton!) {
        coordinator?.viewMovieDetails()
    }
    
    @objc func apiButtonAction(sender: UIButton!) {
        let movie = nowPlayingMovies[0]
        
        requester.request(apiRouter: MovieServiceAPIRouter.getDetails(movieId: movie.id)) { (result: Result<MovieDetailsResponse, NetworkError>) in
            
            switch result {
                case .success(let response): print("\(response.original_title) - \(response.genres) - \(response.overview) - \(response.popularity)")
                case .failure(let error): print(error)
            }
        }
    }
}

extension ViewController: LoadDataProtocol {
    func loadNowPlayingMovies() {
        requester.request(apiRouter: MovieServiceAPIRouter.getNowPlaying(page: 1)) { (result: Result<MoviesResponse, NetworkError>) in
            
            switch result {
                case .success(let response): self.nowPlayingMovies = response.results
                case .failure(let error): print(error)
            }
        }
    }
    
    func loadPopularMovies() {
        requester.request(apiRouter: MovieServiceAPIRouter.getPopular(page: 1)) { (result: Result<MoviesResponse, NetworkError>) in
            
            switch result {
                case .success(let response): self.popularMovies = response.results
                case .failure(let error): print(error)
            }
        }
    }
}

extension ViewController: ViewCodeConfiguration {
    func buildHierarchy() {
        view.addSubview(navButton)
        view.addSubview(apiButton)
    }
    
    func setupConstraints() {}
    
    func configureViews() {
        navButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        navButton.backgroundColor = .red
        navButton.setTitle("Test Button", for: .normal)
        navButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        apiButton.frame = CGRect(x: 100, y: 500, width: 100, height: 50)
        apiButton.backgroundColor = .blue
        apiButton.setTitle("API Button", for: .normal)
        apiButton.addTarget(self, action: #selector(apiButtonAction), for: .touchUpInside)
        
        view.backgroundColor = .white
    }
}
