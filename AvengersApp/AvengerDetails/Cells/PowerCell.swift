//
//  PowerCell.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 27/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class PowerCell: UITableViewCell {
    
    static let cellIndentifier: String = String(describing: PowerCell.self)
    
    lazy var editingButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        guard let pencil = UIImage(systemName: "pencil") else { fatalError() }
        b.setImage(pencil, for: .normal)
        b.tintColor = #colorLiteral(red: 0.02531321719, green: 0.4073432684, blue: 0.903057158, alpha: 1)
        b.addTarget(self, action: #selector(handleEditPower), for: .touchUpInside)
        return b
    }()
    
    lazy var powerImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Superpower"
        label.textColor = #colorLiteral(red: 0.02531321719, green: 0.4073432684, blue: 0.903057158, alpha: 0.6077769887)
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 15)
        return label
    }()
    
    lazy var changeToLabel: UILabel = {
        let label = UILabel()
        label.text = "Change the power:"
        label.isHidden = true
        label.textAlignment = .center
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 15)
        label.textColor = #colorLiteral(red: 0.02531321719, green: 0.4073432684, blue: 0.903057158, alpha: 0.6077769887)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var powerNewValue: UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isHidden = true
        tf.textAlignment = .center
        tf.font = UIFont(name: "Arial-BoldMT", size: 13)
        tf.borderStyle = .roundedRect
        tf.placeholder = "0 - 5"
        tf.backgroundColor = .white
        return tf
    }()
    
    lazy var saveButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        btn.setTitle("Save", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 15)
        btn.setTitleColor(.orange, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(handleSavePower), for: .touchUpInside)
        return btn
    }()
    
    var viewModel: AvengerDetailsCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            if let heroePower = viewModel.heroe?.power {
                setImagePower(heroePower)
            } else {
                guard let villainPower = viewModel.villain?.power else { return }
                setImagePower(villainPower)
            }
            setupUI()
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)

        contentView.addSubview(powerImageView)
        contentView.addSubview(label)
        contentView.addSubview(changeToLabel)
        contentView.addSubview(powerNewValue)
        contentView.addSubview(saveButton)
        contentView.addSubview(editingButton)
        
        NSLayoutConstraint.activate([
            powerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            powerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            powerImageView.widthAnchor.constraint(equalToConstant: 80),
            powerImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
       
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: powerImageView.trailingAnchor, constant: 20),
            label.firstBaselineAnchor.constraint(equalTo: powerImageView.firstBaselineAnchor, constant: 6),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            changeToLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            changeToLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 2),
            changeToLabel.widthAnchor.constraint(equalToConstant: 150),
            changeToLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            powerNewValue.leadingAnchor.constraint(equalTo: changeToLabel.trailingAnchor, constant: 48),
            powerNewValue.centerYAnchor.constraint(equalTo: changeToLabel.centerYAnchor, constant: -2),
            powerNewValue.widthAnchor.constraint(equalToConstant: 50),
            powerNewValue.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            saveButton.lastBaselineAnchor.constraint(equalTo: changeToLabel.lastBaselineAnchor, constant: -8),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            editingButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -2),
            editingButton.widthAnchor.constraint(equalToConstant: 50),
            editingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func handleEditPower() {
        label.isHidden = true
        powerImageView.isHidden = true
        editingButton.isHidden = true
        changeToLabel.isHidden = false
        powerNewValue.isHidden = false
        saveButton.isHidden = false

    }
    
    @objc func handleSavePower() {
        label.isHidden = false
        powerImageView.isHidden = false
        editingButton.isHidden = false
        changeToLabel.isHidden = true
        powerNewValue.isHidden = true
        saveButton.isHidden = true
        
        guard let newPower = powerNewValue.text,
            let newPowerInt = Int(newPower),
            let viewModel = viewModel else { return }
        
        // In addition to send the new power, we need to send if we are in the heroes section an heroe, or a villain if do not.
        if viewModel.heroe != nil {
            // First update coredata with new power
            viewModel.updatePower(newPower: Int16(newPowerInt), heroe: viewModel.heroe, villain: nil)
            // Second retrieve from data (I could directly setImagePower(textfield.text) but I want to test dataProvider)
            guard let powerToUpdate = viewModel.showPowerUpdated(heroe: viewModel.heroe, villain: nil) else { return }
            // Third show power image with new power saved
            setImagePower(powerToUpdate)
        } else {
            // First update coredata with new power
            viewModel.updatePower(newPower: Int16(newPowerInt), heroe: nil, villain: viewModel.villain)
            // Second retrieve from data (I could directly setImagePower(textfield.text) but I want to test dataProvider)
            guard let powerToUpdate = viewModel.showPowerUpdated(heroe: nil, villain: viewModel.villain) else { return }
            // Third show power image with new power saved
            setImagePower(powerToUpdate)
        }
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
}
