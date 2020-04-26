//
//  CombatsViewController.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatsViewController: UIViewController {
    
    // MARK: - Public properties
    let viewModel: CombatsViewModel
    init(viewModel: CombatsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationItem.title = "Combats"
        view.backgroundColor = #colorLiteral(red: 0.77372998, green: 0.8594649434, blue: 0.9724978805, alpha: 1)
    }
}

// MARK: - View model communication
extension CombatsViewController: CombatsViewDelegate {
    
}
