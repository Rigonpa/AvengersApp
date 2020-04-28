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
    
    var viewModel: AvengerDetailsCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            setupUI()
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
    }
    
}
