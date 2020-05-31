//
//  HeroesCell.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 26/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AvengersCell: UITableViewCell {
    // MARK: - Static properties
    // If change TaskViewCell class name must change TaskViewCell.xib cell identifier
    static let cellIdentifier: String = String(describing: AvengersCell.self)
    static let avengersAppFont = "Rockwell-Bold"
    
    // MARK: - Public properties
    lazy var fightButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        guard let image = UIImage(named: "ic_tab_battles")?.withRenderingMode(.alwaysTemplate) else { fatalError() }
        btn.setImage(image, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.addTarget(self, action: #selector(handleAvengerSelectedToFight), for: .touchUpInside)
        btn.isHidden = true
        btn.tintColor = #colorLiteral(red: 0.1956750751, green: 0.285889715, blue: 0.4968746305, alpha: 1)
        return btn
    }()
    
    lazy var powerImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var avengerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.1956750751, green: 0.285889715, blue: 0.4968746305, alpha: 1)
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 17)
        label.textAlignment = .center
        return label
    }()
    
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
    
    var heroesViewModel: HeroesCellViewModel? {
        didSet {
            guard let viewModel = heroesViewModel,
                let profileImageName = viewModel.heroe.profile_image,
                let profileImage = UIImage(named: profileImageName) else { return }
            avengerImageView.image = profileImage
            avengerNameLabel.text = viewModel.heroe.name
            setImagePower(viewModel.heroe.power)
            contentView.backgroundColor = #colorLiteral(red: 0.77372998, green: 0.8594649434, blue: 0.9724978805, alpha: 1)
            setupCellUI()
        }
    }
    
    var villainsViewModel: VillainsCellViewModel? {
        didSet {
            guard let viewModel = villainsViewModel,
                let profileImageName = viewModel.villain.profile_image,
                let profileImage = UIImage(named: profileImageName) else { return }
            avengerImageView.image = profileImage
            avengerNameLabel.text = viewModel.villain.name
            setImagePower(viewModel.villain.power)
            contentView.backgroundColor = #colorLiteral(red: 0.8773142695, green: 0.8238069415, blue: 0.9192584157, alpha: 1)
            setupCellUI()
        }
    }
    
    var choosingAvenger: Bool = false
    
    // MARK: - Private methods
    private func setupCellUI() {
        
        if UserDefaults.standard.bool(forKey: CombatsCoordinator.presentHeroeModule) {
            fightButton.isHidden = false
        }
        
        if UserDefaults.standard.bool(forKey: CombatsCoordinator.presentVillainModule) {
            fightButton.isHidden = false
        }

        contentView.addSubview(avengerImageView)
        contentView.addSubview(avengerNameLabel)
        contentView.addSubview(powerImageView)
        contentView.addSubview(fightButton)
        
        NSLayoutConstraint.activate([
            avengerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avengerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            avengerImageView.widthAnchor.constraint(equalToConstant: 240),
            avengerImageView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            avengerNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avengerNameLabel.topAnchor.constraint(equalTo: avengerImageView.bottomAnchor, constant: 10),
            avengerNameLabel.widthAnchor.constraint(equalTo: avengerImageView.widthAnchor),
            avengerNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            powerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            powerImageView.topAnchor.constraint(equalTo: avengerNameLabel.bottomAnchor, constant: 3),
            powerImageView.widthAnchor.constraint(equalToConstant: 200),
            powerImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            fightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            fightButton.centerYAnchor.constraint(equalTo: avengerImageView.centerYAnchor),
            fightButton.widthAnchor.constraint(equalToConstant: 30),
            fightButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setImagePower(_ power: Int16) {
        switch power {
            case 0:
                let starsImage = UIImage(named: "ic_stars_0")
                powerImageView.image = starsImage
            case 1:
                let starsImage = UIImage(named: "ic_stars_1")
                powerImageView.image = starsImage
            case 2:
                let starsImage = UIImage(named: "ic_stars_2")
                powerImageView.image = starsImage
            case 3:
                let starsImage = UIImage(named: "ic_stars_3")
                powerImageView.image = starsImage
            case 4:
                let starsImage = UIImage(named: "ic_stars_4")
                powerImageView.image = starsImage
            default:
                let starsImage = UIImage(named: "ic_stars_5")
                powerImageView.image = starsImage
        }
    }
    
    @objc private func handleAvengerSelectedToFight() {
        if let heroeSelected = heroesViewModel?.heroe {
            heroesViewModel?.heroeForFightSelected(heroe: heroeSelected)
        } else if let villainSelected = villainsViewModel?.villain {
            villainsViewModel?.villainForFightSelected(villain: villainSelected)
        }
    }
}
