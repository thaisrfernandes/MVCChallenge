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
    private lazy var searchBarController = { return UISearchController() }()
    
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
        self.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchBarController

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "Secondary")
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        view.backgroundColor = .systemBackground
    }
}
