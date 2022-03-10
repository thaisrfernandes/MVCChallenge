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
        //applyViewCode()
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
        
        print(nowPlayingMovies)
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
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func configureViews() {
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
        view.backgroundColor = .systemBackground
    }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieListCell

      cell.title.text = "Spider-Man: No Way Home"
      cell.overview.text = "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man."
      cell.rate.text = "8.3"
      
    return cell
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                    "sectionHeader") as! SectionHeader
        view.title.text = "Popular Movies"

        return view
    }
}

