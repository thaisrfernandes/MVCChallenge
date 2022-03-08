//
//  ViewController.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 04/03/22.
//

import UIKit

class ViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    private lazy var navButton = { return UIButton(frame: .zero) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
    }
    
    @objc func buttonAction(sender: UIButton!) {
        coordinator?.viewMovieDetails()
    }
}

extension ViewController: ViewCodeConfiguration {
    func buildHierarchy() {
        view.addSubview(navButton)
    }
    
    func setupConstraints() {}
    
    func configureViews() {
        navButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        navButton.backgroundColor = .red
        navButton.setTitle("Test Button", for: .normal)
        navButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        view.backgroundColor = .white
    }
    
}
