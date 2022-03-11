//
//  SectionHeader.swift
//  MVCChallenge
//
//  Created by Thaís Fernandes on 10/03/22.
//

import Foundation
import UIKit

class SectionHeader: UITableViewHeaderFooterView {
    lazy var title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionHeader: ViewCodeConfiguration {
    func buildHierarchy() {
        contentView.addSubview(title)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configureViews() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
}
