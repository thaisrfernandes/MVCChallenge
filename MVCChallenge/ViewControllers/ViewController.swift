//
//  ViewController.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 04/03/22.
//

import UIKit

class ViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .red
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        view.backgroundColor = .white
        
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        coordinator?.viewMovieDetails()
    }
}

