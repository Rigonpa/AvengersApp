//
//  VillainsCoordinator.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class VillainsCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let dataProvider: DataProvider
    
    init(presenter: UINavigationController, dataProvider: DataProvider) {
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
    
    override func start() {
        let villainsViewModel = VillainsViewModel(dataProvider: dataProvider)
        let villainsViewController = VillainsViewController(viewModel: villainsViewModel)
        
        villainsViewModel.coordinatorDelegate = self
        villainsViewModel.viewDelegate = villainsViewController
        
        presenter.pushViewController(villainsViewController, animated: true)
    }
    
    override func finish() {
        
    }
}

// View model communication
extension VillainsCoordinator: VillainsCoordinatorDelegate {
    
}
