//
//  CombatsCoordinator.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatsCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let dataProvider: DataProvider
    
    init(presenter: UINavigationController, dataProvider: DataProvider) {
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
    
    override func start() {
        let combatsViewModel = CombatsViewModel(dataProvider: dataProvider)
        let combatsViewController = CombatsViewController(viewModel: combatsViewModel)
        
        combatsViewModel.coordinatorDelegate = self
        combatsViewModel.viewDelegate = combatsViewController
        
        presenter.pushViewController(combatsViewController, animated: true)
    }
    
    override func finish() {
        
    }
}

// View model communication
extension CombatsCoordinator: CombatsCoordinatorDelegate {
    
}
