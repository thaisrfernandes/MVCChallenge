//
//  MovieDetailsViewController.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 04/03/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.textAlignment = .center
        label.text = "MovieDetails ViewController"
        
        view.backgroundColor = .white
                
        self.view.addSubview(label)
    }
}
