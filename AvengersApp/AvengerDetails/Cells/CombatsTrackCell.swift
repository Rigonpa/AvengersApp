//
//  CombatsCell.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 27/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatsTrackCell: UITableViewCell {
    
    static let cellIndentifier: String = String(describing: CombatsTrackCell.self)
    
    var combats: [String] = ["Combat 1", "Combat 2", "Combat 3", "Combat 4", "Combat 5",
                             "Combat 6", "Combat 7", "Combat 8", "Combat 9", "Combat 10",
                             "Combat 11", "Combat 12", "Combat 13", "Combat 14", "Combat 15",
                             "Combat 16", "Combat 17", "Combat 18", "Combat 19", "Combat 20"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        cv.register(CombatsUnitaryCell.self, forCellWithReuseIdentifier: "CellId")
        return cv
    }()
    
    var viewModel: AvengerDetailsCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            setupUI()
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
}

// MARK: - Collection view methods
extension CombatsTrackCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: contentView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return combats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as? CombatsUnitaryCell else { fatalError()}
//        item.combatLabel.text = combats[indexPath.item]
        item.emptyCombatLabel.text = combats[indexPath.item]
//        item.backgroundColor = .blue
        return item
    }
    
    
}

class CombatsUnitaryCell: UICollectionViewCell {
    
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
    
    lazy var rivalLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "This was my rival"
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 10)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(combatLabel)
        contentView.addSubview(rivalLabel)
        contentView.addSubview(emptyCombatLabel)
        contentView.addSubview(emptyRivalLabel)

        NSLayoutConstraint.activate([
            combatLabel.centerXAnchor.constraint(equalTo: rivalLabel.centerXAnchor),
            combatLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            combatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            combatLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            rivalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rivalLabel.topAnchor.constraint(equalTo: combatLabel.bottomAnchor, constant: 7),
            rivalLabel.widthAnchor.constraint(equalToConstant: 115),
            rivalLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emptyCombatLabel.centerXAnchor.constraint(equalTo: emptyRivalLabel.centerXAnchor),
            emptyCombatLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            emptyCombatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            emptyCombatLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emptyRivalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emptyRivalLabel.topAnchor.constraint(equalTo: emptyCombatLabel.bottomAnchor, constant: 7),
            emptyRivalLabel.widthAnchor.constraint(equalToConstant: 115),
            emptyRivalLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
