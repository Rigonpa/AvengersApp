//
//  DescriptionCell.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 27/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 18)
        label.text = "Biography"
        label.textColor = #colorLiteral(red: 0.1956750751, green: 0.285889715, blue: 0.4968746305, alpha: 1)
        return label
    }()
    
    lazy var biographyText: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        tv.isSelectable = false
//        tv.isScrollEnabled = false
        tv.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        tv.font = UIFont(name: AvengersCell.avengersAppFont, size: 13)
        tv.textColor = #colorLiteral(red: 0.02531321719, green: 0.4073432684, blue: 0.903057158, alpha: 0.6077769887)
        tv.textAlignment = .justified
        tv.layer.borderColor = UIColor.clear.cgColor
        return tv
    }()
    
    static let cellIndentifier: String = String(describing: DescriptionCell.self)
    
    var viewModel: AvengerDetailsCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            if viewModel.heroe != nil {
                biographyText.text = viewModel.heroe?.character_story
            } else {
                biographyText.text = viewModel.villain?.character_story
            }
            setupUI()
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)

        contentView.addSubview(biographyLabel)
        contentView.addSubview(biographyText)
        
        NSLayoutConstraint.activate([
            biographyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            biographyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            biographyLabel.widthAnchor.constraint(equalToConstant: 300),
            biographyLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            biographyText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            biographyText.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 10),
            biographyText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            biographyText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
