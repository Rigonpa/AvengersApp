//
//  CombatsCell.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 27/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatsTrackCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellIndentifier: String = String(describing: CombatsTrackCell.self)
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        cv.showsHorizontalScrollIndicator = false
        cv.register(CombatItem.self, forCellWithReuseIdentifier: CombatItem.cellIdentifier)
        return cv
    }()
    
    var viewModel: CombatsTrackCellViewModel? {
        didSet {
            setupUI()
        }
    }
    
    // MARK: - Private methods
    private func setupUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        collectionView.reloadData()
    }
}

// MARK: - Collection view methods
extension CombatsTrackCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let itemSize = viewModel?.itemSize() else { fatalError() }
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { fatalError() }
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: CombatItem.cellIdentifier, for: indexPath) as? CombatItem else { fatalError() }
        let itemViewModel = viewModel.viewModel(indexPath: indexPath)
        item.viewModel = itemViewModel
        return item
    }
}
