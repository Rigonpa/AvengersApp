//
//  CombatsCoordinator.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatsCoordinator: Coordinator {
    static var presentHeroeModule = "Presenting heroe module"
    static var presentVillainModule = "Presenting villain module"

    let presenter: UINavigationController
    let dataProvider: DataProvider
    var combatsViewModel: CombatsViewModel?
    
    init(presenter: UINavigationController, dataProvider: DataProvider) {
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
    
    override func start() {
        let combatsViewModel = CombatsViewModel(dataProvider: dataProvider)
        let combatsViewController = CombatsViewController(viewModel: combatsViewModel)
        
        self.combatsViewModel = combatsViewModel // ****** THE MOST IMPORTANT STEP I ALWAYS FORGET ******
        
        combatsViewModel.coordinatorDelegate = self
        combatsViewModel.viewDelegate = combatsViewController
        
        presenter.pushViewController(combatsViewController, animated: true)
    }
    
    override func finish() {
        
    }
}

// View model communication
extension CombatsCoordinator: CombatsCoordinatorDelegate {
    
    func onChoosingHeroeForFighting() {
        let heroesCoordinator = HeroesCoordinator(presenter: presenter, dataProvider: dataProvider)
        addChildCoordinator(coordinator: heroesCoordinator)
        heroesCoordinator.presentModule()
        
        heroesCoordinator.onHeroeChosenBlock = {[weak self] in
            guard let self = self else { return }
            UserDefaults.standard.removeObject(forKey: CombatsCoordinator.presentHeroeModule)
            self.combatsViewModel?.onAvengerWasAssignedToCombat()
            heroesCoordinator.finish()
            self.removeChildCoordinator(coordinator: heroesCoordinator)
        }
    }
    
    func onChoosingVillainForFighting() {
        let villainCoordinator = VillainsCoordinator(presenter: presenter, dataProvider: dataProvider)
        addChildCoordinator(coordinator: villainCoordinator)
        villainCoordinator.presentModule()
        
        villainCoordinator.onVillainChosenBlock = {[weak self] in
            guard let self = self else { return }
            UserDefaults.standard.removeObject(forKey: CombatsCoordinator.presentVillainModule)
            self.combatsViewModel?.onAvengerWasAssignedToCombat()
            villainCoordinator.finish()
            self.removeChildCoordinator(coordinator: villainCoordinator)
        }
    }
}
