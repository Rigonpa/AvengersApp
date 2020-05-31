//
//  CombatItem.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 30/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatItem: UICollectionViewCell {
    static var cellIdentifier: String = String(describing: CombatItem.self)
    
    lazy var combatLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.backgroundColor = #colorLiteral(red: 0.5712776184, green: 0.1726597846, blue: 0.2487661541, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 10)
        label.textColor = .white
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var combatShadowView: CustomView = {
        let view = CustomView(cornerRadius: 15,
                              shadowColor: UIColor.black.withAlphaComponent(0.4).cgColor,
                              xOffset: 0,
                              yOffset: 2,
                              alpha: 1,
                              shadowRadius: 3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var rivalLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .center
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 10)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var rivalShadowView: CustomView = {
        let view = CustomView(cornerRadius: 15,
                              shadowColor: UIColor.black.withAlphaComponent(0.2).cgColor,
                              xOffset: 0,
                              yOffset: 2,
                              alpha: 0.8,
                              shadowRadius: 3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()

    lazy var emptyCombatLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 10)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7488585633)
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7488585633)
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var emptyRivalLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Opponent"
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 10)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7488585633)
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7488585633)
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
    var viewModel: CombatItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            
            switch viewModel.combatState {
            case .finished:
                // The combats where this avenger has been involved
                combatShadowView.isHidden = false
                rivalShadowView.isHidden = false
                combatLabel.isHidden = false
                rivalLabel.isHidden = false
                emptyCombatLabel.isHidden = true
                emptyRivalLabel.isHidden = true
                
                let combatAnalyzed = viewModel.combat
                combatLabel.text = "Combat \(viewModel.combatNumber)"

                if viewModel.viewedFrom == .heroeSection {
                    // Heroe combat analyzed
                    rivalLabel.text = combatAnalyzed?.villain?.name
                    if combatAnalyzed?.heroe?.name == combatAnalyzed?.winner {
                        // The heroe won the combat - Yellow bubble
                        combatLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                        combatLabel.textColor = .black
                        combatShadowView.shadowColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                    } else {
                        // The heroe lost the combat - Red bubble
                        combatLabel.backgroundColor = #colorLiteral(red: 0.5712776184, green: 0.1726597846, blue: 0.2487661541, alpha: 1)
                        combatLabel.textColor = .white
                        combatShadowView.shadowColor = #colorLiteral(red: 0.5712776184, green: 0.1726597846, blue: 0.2487661541, alpha: 1)
                    }
                } else {
                    // Villain combat analyzed
                    rivalLabel.text = combatAnalyzed?.heroe?.name
                    if combatAnalyzed?.villain?.name == combatAnalyzed?.winner {
                        // The villain won the combat - Yellow bubble
                        combatLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                        combatLabel.textColor = .black
                        combatShadowView.shadowColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                    } else {
                        // The villain lost the combat - Red bubble
                        combatLabel.backgroundColor = #colorLiteral(red: 0.5712776184, green: 0.1726597846, blue: 0.2487661541, alpha: 1)
                        combatLabel.textColor = .white
                        combatShadowView.shadowColor = #colorLiteral(red: 0.5712776184, green: 0.1726597846, blue: 0.2487661541, alpha: 1)
                    }
                }
            case .future:
                // The rest of combats until 20 where this avenger will be involved
                combatLabel.isHidden = true
                rivalLabel.isHidden = true
                emptyCombatLabel.isHidden = false
                emptyRivalLabel.isHidden = false
                rivalShadowView.isHidden = true
                combatShadowView.isHidden = true

                emptyCombatLabel.text = "Combat \(viewModel.combatNumber)"
            case .none:
                break
            }
            
            placeConstraints()
        }
    }
    
    private func placeConstraints() {
        
        contentView.addSubview(combatShadowView)
        contentView.addSubview(rivalShadowView)

        contentView.addSubview(combatLabel)
        contentView.addSubview(rivalLabel)
        contentView.addSubview(emptyCombatLabel)
        contentView.addSubview(emptyRivalLabel)
        
        NSLayoutConstraint.activate([
            combatLabel.centerXAnchor.constraint(equalTo: rivalLabel.centerXAnchor, constant: 2),
            combatLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            combatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            combatLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            combatShadowView.centerXAnchor.constraint(equalTo: rivalLabel.centerXAnchor, constant: 2),
            combatShadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            combatShadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            combatShadowView.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            rivalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            rivalLabel.topAnchor.constraint(equalTo: combatLabel.bottomAnchor, constant: 7),
            rivalLabel.widthAnchor.constraint(equalToConstant: 115),
            rivalLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            rivalShadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            rivalShadowView.topAnchor.constraint(equalTo: combatLabel.bottomAnchor, constant: 7),
            rivalShadowView.widthAnchor.constraint(equalToConstant: 115),
            rivalShadowView.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            emptyCombatLabel.centerXAnchor.constraint(equalTo: emptyRivalLabel.centerXAnchor, constant: 2),
            emptyCombatLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            emptyCombatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            emptyCombatLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emptyRivalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            emptyRivalLabel.topAnchor.constraint(equalTo: emptyCombatLabel.bottomAnchor, constant: 7),
            emptyRivalLabel.widthAnchor.constraint(equalToConstant: 115),
            emptyRivalLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
