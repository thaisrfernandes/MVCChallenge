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
    
    private lazy var searchBarController = { return UISearchController() }()
    private lazy var tableView = { return UITableView(frame: .zero) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        applyViewCode()
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
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        
        self.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchBarController
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "Secondary")
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        tableView.register(SectionHeader.self,
                           forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "cell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

extension ViewController: UITableViewDataSource {
    enum MovieSections: Int {
        case nowPlaying = 1
        case popular = 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == MovieSections.nowPlaying.rawValue {
            return nowPlayingMovies.count
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieListCell
        
        if let path = popularMovies[indexPath.row].poster_path, let url = MovieServiceAPIRouter.getImage(poster_path: path).pathURL {
            cell.poster.load(url: url)
        }
        
        cell.title.text = popularMovies[indexPath.row].title
        cell.overview.text = popularMovies[indexPath.row].overview
        cell.rate.text = String(popularMovies[indexPath.row].vote_average)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                "sectionHeader") as! SectionHeader
        
        view.title.text = (section == MovieSections.nowPlaying.rawValue) ? "Now Playing" : "Popular Movies"
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieList = indexPath.section == MovieSections.nowPlaying.rawValue ? nowPlayingMovies : popularMovies
        
        let selectedMovie = movieList[indexPath.row]
        
        coordinator?.viewMovieDetails(movie: selectedMovie)
    }
    
}

