//
//  MovieDetailsViewController.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 04/03/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var coordinator: MainCoordinator?
    var requester = Requester()
    
    var movie: Movie? {
        didSet {
            movieTitle.text = movie?.title
            ratingNumber.text = String(movie?.vote_average ?? 0.0)
            contentLabel.text = movie?.overview
            if let posterPath = movie?.poster_path, let url = MovieServiceAPIRouter.getImage(poster_path: posterPath).pathURL {
                movieImageView.load(url: url)
            }
            if let movieId = movie?.id {
                getGenres(movieId: movieId)
            }
        }
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
    }
    
    private lazy var movieImageView: UIImageView = {
        let movieImage = UIImageView()
        movieImage.layer.masksToBounds = true
        movieImage.layer.cornerRadius = 10
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "movie title"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieGenres: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: "Quarternary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star")
        image.tintColor = UIColor(named: "Terciary")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var ratingNumber: UILabel = {
        let label = UILabel()
        label.text = "2.3"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "Quarternary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentTitle: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "Primary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var movieDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func getGenres(movieId: Int) {
        requester.request(apiRouter: MovieServiceAPIRouter.getDetails(movieId: movieId)) { (result: Result<MovieDetailsResponse, NetworkError>) in
            switch result {
            case .success(let success):
                var genresName = success.genres.map { $0.name }
                DispatchQueue.main.async {
                    self.movieGenres.text = genresName.first ?? ""
                    genresName.remove(at: 0)
                    genresName.forEach { movieGenre in
                        self.movieGenres.text = "\(self.movieGenres.text ?? ""), \(movieGenre)"
                    }
                }
            case .failure:
                self.movieGenres.text = nil
            }
        }
    }
}

extension MovieDetailsViewController: ViewCodeConfiguration {
    func buildHierarchy() {
        view.addSubview(scrollView)
        
        infoView.addSubview(movieInfoStackView)
        
        ratingStackView.addArrangedSubview(ratingImage)
        ratingStackView.addArrangedSubview(ratingNumber)

        movieInfoStackView.addArrangedSubview(movieTitle)
        movieInfoStackView.addArrangedSubview(movieGenres)
        movieInfoStackView.addArrangedSubview(ratingStackView)

        movieDetailsStackView.addArrangedSubview(movieImageView)
        movieDetailsStackView.addArrangedSubview(infoView)

        mainStackView.addArrangedSubview(movieDetailsStackView)
        mainStackView.addArrangedSubview(contentTitle)
        mainStackView.addArrangedSubview(contentLabel)

        contentView.addSubview(mainStackView)
        scrollView.addSubview(contentView)
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        movieImageView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 194).isActive = true
        
        movieInfoStackView.topAnchor.constraint(lessThanOrEqualTo: infoView.topAnchor, constant: 85).isActive = true
        movieInfoStackView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor).isActive = true
        movieInfoStackView.rightAnchor.constraint(equalTo: infoView.rightAnchor).isActive = true
        movieInfoStackView.leftAnchor.constraint(equalTo: infoView.leftAnchor).isActive = true
        
        mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 21).isActive = true
        mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -28).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18).isActive = true
    }
    
    func configureViews() {
        self.title = "Details"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "Secondary")
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        view.backgroundColor = .systemBackground
    }
    
}
