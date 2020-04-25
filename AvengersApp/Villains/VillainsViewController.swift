//
//  VillainsViewController.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class VillainsViewController: UIViewController {
    
    // MARK: - Public properties
    let viewModel: VillainsViewModel
    init(viewModel: VillainsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.8773142695, green: 0.8238069415, blue: 0.9192584157, alpha: 1)
    }
}

// MARK: - View model communication
extension VillainsViewController: VillainsViewDelegate {
    
}
