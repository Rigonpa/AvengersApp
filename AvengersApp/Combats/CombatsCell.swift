//
//  CombatsCell.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 28/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatsCell: UITableViewCell {
    
    static let cellIdentifier: String = String(describing: CombatsCell.self)
    
    lazy var heroeWinnerImageView: UIImageView = {
        let image = UIImage(systemName: "bolt.fill")
        let iv = UIImageView(image: image)
        iv.isHidden = true
        iv.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var heroeLoserImageView: UIImageView = {
        let image = UIImage(systemName: "hand.thumbsdown.fill")
        let iv = UIImageView(image: image)
        iv.isHidden = true
        iv.tintColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    lazy var villainWinnerImageView: UIImageView = {
        let image = UIImage(systemName: "bolt.fill")
        let iv = UIImageView(image: image)
        iv.isHidden = true
        iv.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var villainLoserImageView: UIImageView = {
        let image = UIImage(systemName: "hand.thumbsdown.fill")
        let iv = UIImageView(image: image)
        iv.isHidden = true
        iv.tintColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var combatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1956750751, green: 0.285889715, blue: 0.4968746305, alpha: 1)
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 18)
        return label
    }()
    
    lazy var fightButton: UIButton = {
        let label = UILabel()
        label.text = "GO!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 13)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let btn = UIButton(type: .system)
        btn.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: btn.centerYAnchor, constant: 2),
            label.widthAnchor.constraint(equalTo: btn.widthAnchor),
            label.heightAnchor.constraint(equalTo: btn.heightAnchor)
        ])
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        btn.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        btn.addTarget(self, action: #selector(handleFightStarted), for: .touchUpInside)
        return btn
    }()
    
    lazy var heroeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.isHidden = true
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var villainImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.isHidden = true
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var withoutVillainImageView: UIButton = {
        let label = UILabel()
        label.text = "Choose villain"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 17)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let btn = UIButton(type: .system)
        btn.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: btn.centerYAnchor, constant: 2),
            label.widthAnchor.constraint(equalTo: btn.widthAnchor),
            label.heightAnchor.constraint(equalTo: btn.heightAnchor)
        ])
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        btn.addTarget(self, action: #selector(handleChooseVillain), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.8015423417, green: 0.5596194863, blue: 0.5582501888, alpha: 1)
        return btn
    }()
    
    lazy var withoutHeroeImageView: UIButton = {
        let label = UILabel()
        label.text = "Choose heroe"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 17)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let btn = UIButton(type: .system)
        btn.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: btn.centerYAnchor, constant: 2),
            label.widthAnchor.constraint(equalTo: btn.widthAnchor),
            label.heightAnchor.constraint(equalTo: btn.heightAnchor)
        ])
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = false
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        btn.addTarget(self, action: #selector(handleChooseHeroe), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.8015423417, green: 0.5596194863, blue: 0.5582501888, alpha: 1)
        return btn
    }()
    
    var viewModel: CombatsCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            if viewModel.combat.heroe != nil {
                guard let heroeImageName = viewModel.combat.heroe?.profile_image else { return }
                let heroeImage = UIImage(named: heroeImageName)
                heroeImageView.image = heroeImage
                
                withoutHeroeImageView.isHidden = true
                heroeImageView.isHidden = false
                withoutVillainImageView.isHidden = false
            }
            
            if viewModel.combat.villain != nil {
                guard let villainImageName = viewModel.combat.villain?.profile_image else { return }
                let villainImage = UIImage(named: villainImageName)
                villainImageView.image = villainImage
                
                withoutVillainImageView.isHidden = true
                villainImageView.isHidden = false
                fightButton.isHidden = false
            }
            
            combatLabel.text = "Combat #\(viewModel.combat.combat_id)"
            setupUI()
            
            
            
            
            
//            // Showing heroe, or villain or heroe and villain images
//            guard let viewModel = viewModel,
//                let heroeImageName = viewModel.combat.heroe?.profile_image,
//                let heroeImage = UIImage(named: heroeImageName),
//                let villainImageName = viewModel.combat.villain?.profile_image,
//                let villainImage = UIImage(named: villainImageName) else {
//
//                    // When combat is new and has no heroe or villain
//                    setupUI()
//                    return
//
//            }
//            heroeImageView.image = heroeImage
//            villainImageView.image = villainImage
//            setupUI()
        }
    }
    
    // MARK: - Private methods
    private func setupUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        
        contentView.addSubview(heroeImageView)
        contentView.addSubview(villainImageView)
        contentView.addSubview(withoutHeroeImageView)
        contentView.addSubview(withoutVillainImageView)
        
        contentView.addSubview(fightButton)
        contentView.addSubview(combatLabel)

        contentView.addSubview(heroeWinnerImageView)
        contentView.addSubview(heroeLoserImageView)
        contentView.addSubview(villainWinnerImageView)
        contentView.addSubview(villainLoserImageView)

        NSLayoutConstraint.activate([
            heroeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            heroeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroeImageView.widthAnchor.constraint(equalToConstant: 150),
            heroeImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            villainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            villainImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            villainImageView.widthAnchor.constraint(equalToConstant: 150),
            villainImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            withoutHeroeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            withoutHeroeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            withoutHeroeImageView.widthAnchor.constraint(equalToConstant: 150),
            withoutHeroeImageView.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            withoutVillainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            withoutVillainImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            withoutVillainImageView.widthAnchor.constraint(equalToConstant: 150),
            withoutVillainImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            fightButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fightButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            fightButton.widthAnchor.constraint(equalToConstant: 40),
            fightButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            combatLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            combatLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            combatLabel.widthAnchor.constraint(equalToConstant: 200),
            combatLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            heroeWinnerImageView.leadingAnchor.constraint(equalTo: heroeImageView.leadingAnchor, constant: 4),
            heroeWinnerImageView.topAnchor.constraint(equalTo: heroeImageView.topAnchor, constant: 4),
            heroeWinnerImageView.widthAnchor.constraint(equalToConstant: 30),
            heroeWinnerImageView.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            heroeLoserImageView.trailingAnchor.constraint(equalTo: heroeImageView.trailingAnchor, constant: -4),
            heroeLoserImageView.topAnchor.constraint(equalTo: heroeImageView.topAnchor, constant: 4),
            heroeLoserImageView.widthAnchor.constraint(equalToConstant: 30),
            heroeLoserImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            villainWinnerImageView.leadingAnchor.constraint(equalTo: villainImageView.leadingAnchor, constant: 4),
            villainWinnerImageView.topAnchor.constraint(equalTo: villainImageView.topAnchor, constant: 4),
            villainWinnerImageView.widthAnchor.constraint(equalToConstant: 30),
            villainWinnerImageView.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            villainLoserImageView.trailingAnchor.constraint(equalTo: villainImageView.trailingAnchor, constant: -4),
            villainLoserImageView.topAnchor.constraint(equalTo: villainImageView.topAnchor, constant: 4),
            villainLoserImageView.widthAnchor.constraint(equalToConstant: 30),
            villainLoserImageView.heightAnchor.constraint(equalToConstant: 30)
        ])

    }
    
    @objc private func handleFightStarted() {
        
    }
    
    @objc private func handleChooseHeroe() {
        viewModel?.onWillChooseHeroe()
    }
    
    @objc private func handleChooseVillain() {
        viewModel?.onWillChooseVillain()
    }
}
