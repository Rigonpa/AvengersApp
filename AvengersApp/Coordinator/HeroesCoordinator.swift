//
//  HeroesCoordinator.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class HeroesCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let dataProvider: DataProvider
    
    init(presenter: UINavigationController, dataProvider: DataProvider) {
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
    
    override func start() {
        let heroesViewModel = HeroesViewModel(dataProvider: dataProvider)
        let heroesViewController = HeroesViewController(viewModel: heroesViewModel)
        
        heroesViewModel.coordinatorDelegate = self
        heroesViewModel.viewDelegate = heroesViewController
        
        presenter.pushViewController(heroesViewController, animated: true)
    }
    
    override func finish() {
        
    }
    
}

// View model communications
extension HeroesCoordinator: HeroesCoordinatorDelegate {
    
}
