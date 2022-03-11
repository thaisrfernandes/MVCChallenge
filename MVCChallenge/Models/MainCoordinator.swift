//
//  MainCoordinator.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 04/03/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var nav: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.nav = navigationController
    }
    
    func start() {
        let vc = ViewController() as ViewController
        vc.coordinator = self
        nav.pushViewController(vc, animated: false)
    }
    
    func viewMovieDetails(movie: Movie) {
        let vc = MovieDetailsViewController() as MovieDetailsViewController
        vc.coordinator = self
        vc.movie = movie
        nav.pushViewController(vc, animated: true)
    }
}
