//
//  MovieListCell.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 10/03/22.
//

import Foundation
import UIKit

class MovieListCell: UITableViewCell {
    var poster = UIImageView()
    var title = UILabel()
    var overview = UILabel()
    var rate = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListCell: ViewCodeConfiguration {
    func buildHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(overview)
        contentView.addSubview(rate)
        contentView.addSubview(poster)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            poster.widthAnchor.constraint(equalToConstant: 79),
            poster.heightAnchor.constraint(equalToConstant: 118),
            
            title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            overview.topAnchor.constraint(equalTo: title.bottomAnchor),
            overview.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            rate.bottomAnchor.constraint(equalTo: poster.bottomAnchor, constant: -5),
            rate.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            rate.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
        ])
    }
    
    func configureViews() {
        poster.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        rate.translatesAutoresizingMaskIntoConstraints = false

        poster.image = UIImage(named: "image")
        
        title.backgroundColor = .darkGray
        overview.numberOfLines = 3
        overview.backgroundColor = .systemPink
        
    }
    
    
}
