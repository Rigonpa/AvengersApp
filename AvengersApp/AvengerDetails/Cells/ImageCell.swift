//
//  ImageCell.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 27/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    static let cellIndentifier: String = String(describing: ImageCell.self)
    
    lazy var avengerImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    var viewModel: AvengerDetailsCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            if let heroeImageName = viewModel.heroe?.profile_image {
                let avengerImageName = heroeImageName
                let selectedAvengerImage = UIImage(named: avengerImageName)
                avengerImageView.image = selectedAvengerImage
            } else {
                guard let villainImageName = viewModel.villain?.profile_image else { return }
                let avengerImageName = villainImageName
                let selectedAvengerImage = UIImage(named: avengerImageName)
                avengerImageView.image = selectedAvengerImage
            }
            setupUI()
        }
    }
    
    func setupUI() {
        contentView.addSubview(avengerImageView)
        contentView.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        NSLayoutConstraint.activate([
            avengerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avengerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 15),
            avengerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            avengerImageView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
}
