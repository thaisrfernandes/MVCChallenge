//
//  MovieListCell.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 10/03/22.
//

import Foundation
import UIKit

class MovieListCell: UITableViewCell {
    var rateStackView = UIStackView()
    var stackView = UIStackView()
    var poster = UIImageView()
    var title = UILabel()
    var overview = UILabel()
    var rate = UILabel()
    var rateImage = UIImageView()
    
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
        rateStackView.addArrangedSubview(rateImage)
        rateStackView.addArrangedSubview(rate)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(overview)
        stackView.addArrangedSubview(rateStackView)
        contentView.addSubview(poster)
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            poster.widthAnchor.constraint(equalToConstant: 79),
            poster.heightAnchor.constraint(equalToConstant: 118),
            poster.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.centerYAnchor.constraint(equalTo: poster.centerYAnchor),
            
            rateImage.widthAnchor.constraint(equalToConstant: 14),
            rateImage.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    func configureViews() {
        poster.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        rate.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        rateStackView.translatesAutoresizingMaskIntoConstraints = false
        rateImage.translatesAutoresizingMaskIntoConstraints = false
        
        poster.layer.cornerRadius = 10
        poster.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 16
        
        title.font = UIFont.systemFont(ofSize: 14, weight: .semibold)

        overview.font = UIFont.systemFont(ofSize: 13)
        overview.textColor = UIColor(named: "Primary")
        overview.numberOfLines = 3

        rate.font = UIFont.systemFont(ofSize: 12)
        rate.textColor = UIColor.systemGray
        
        rateImage.image = UIImage(systemName: "star")
        rateImage.tintColor = UIColor.systemGray
        
        rateStackView.axis = .horizontal
        rateStackView.alignment = .center
        rateStackView.distribution = .fill
        rateStackView.spacing = 5
    }
    
    
}
