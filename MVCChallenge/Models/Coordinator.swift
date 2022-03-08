//
//  Coordinator.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 04/03/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var nav: UINavigationController { get set }
    
    func start()
}
