//
//  HeroesCoordinator.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class HeroesCoordinator: Coordinator {
    
    var onHeroeChosenBlock: (() -> Void)?
    
    let presenter: UINavigationController
    let dataProvider: DataProvider
    
//    var chooseHeroeNavigationController: UINavigationController?
    
    var heroesViewModel: HeroesViewModel?
    
    init(presenter: UINavigationController, dataProvider: DataProvider) {
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
    
    override func start() {
        let heroesViewModel = HeroesViewModel(dataProvider: dataProvider)
        let heroesViewController = HeroesViewController(viewModel: heroesViewModel)
        
        heroesViewModel.coordinatorDelegate = self
        heroesViewModel.viewDelegate = heroesViewController
        self.heroesViewModel = heroesViewModel // ****** THE MOST IMPORTANT STEP I ALWAYS FORGET ******
        
        presenter.pushViewController(heroesViewController, animated: true)
    }
    
    override func finish() {
        presenter.dismiss(animated: true, completion: nil)
    }
    
    override func presentModule() {
        let heroesViewModel = HeroesViewModel(dataProvider: dataProvider)
        let heroesViewController = HeroesViewController(viewModel: heroesViewModel)
        
        heroesViewController.title = "Select heroe for combat"
        
        heroesViewModel.coordinatorDelegate = self
        heroesViewModel.viewDelegate = heroesViewController
        self.heroesViewModel = heroesViewModel // ****** THE MOST IMPORTANT STEP I ALWAYS FORGET ******
        
        UserDefaults.standard.set(true, forKey: CombatsCoordinator.presentHeroeModule)
        
//        let navigationController = UINavigationController(rootViewController: heroesViewController)
//        self.chooseHeroeNavigationController = navigationController
//        navigationController.modalPresentationStyle = .fullScreen
//        presenter.present(navigationController, animated: true, completion: nil)

        heroesViewController.modalPresentationStyle = .fullScreen
        presenter.present(heroesViewController, animated: true, completion: nil)

    }
    
}

// MARK: - View model communications
extension HeroesCoordinator: HeroesCoordinatorDelegate {
    func onHeroeWasAssignedToCombat() {()
        onHeroeChosenBlock?()
    }
    
    func onDetailRequestedFor(_ heroe: Heroe) {
        let avengerDetailsViewModel = AvengerDetailsViewModel(dataProvider: dataProvider)
        let avengerDetailsViewController = AvengerDetailsViewController(viewModel: avengerDetailsViewModel)
        
        avengerDetailsViewModel.coordinatorDelegate = self
        avengerDetailsViewModel.viewDelegate = avengerDetailsViewController
        
        avengerDetailsViewModel.onWillShowHeroeDetails(heroe)
        presenter.pushViewController(avengerDetailsViewController, animated: true)
        
        avengerDetailsViewModel.onPowerWasUpdated = {[weak self] in
            guard let self = self else { return }
            self.heroesViewModel?.onPowerWasUpdated()
        }
    }
}

// Avengers detail view model communication
extension HeroesCoordinator: AvengerDetailsCoordinatorDelegate {
    
}
