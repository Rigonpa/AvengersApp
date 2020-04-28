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
    
    var villainsViewModel: VillainsViewModel?
    
    init(presenter: UINavigationController, dataProvider: DataProvider) {
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
    
    override func start() {
        let villainsViewModel = VillainsViewModel(dataProvider: dataProvider)
        let villainsViewController = VillainsViewController(viewModel: villainsViewModel)
        
        villainsViewModel.coordinatorDelegate = self
        villainsViewModel.viewDelegate = villainsViewController
        self.villainsViewModel = villainsViewModel // ****** THE MOST IMPORTANT STEP I ALWAYS FORGET ******
        
        presenter.pushViewController(villainsViewController, animated: true)
    }
    
    override func finish() {
        
    }
}

// View model communication
extension VillainsCoordinator: VillainsCoordinatorDelegate {
    func onDetailRequestedFor(_ villain: Villain) {
        let avengerDetailsViewModel = AvengerDetailsViewModel(dataProvider: dataProvider)
        let avengerDetailsViewController = AvengerDetailsViewController(viewModel: avengerDetailsViewModel)
        
        avengerDetailsViewModel.coordinatorDelegate = self
        avengerDetailsViewModel.viewDelegate = avengerDetailsViewController
        
        avengerDetailsViewModel.onWillShowVillainDetails(villain)
        presenter.pushViewController(avengerDetailsViewController, animated: true)
        
        avengerDetailsViewModel.onPowerWasUpdated = {[weak self] in
            guard let self = self else { return }
            self.villainsViewModel?.onPowerWasUpdated()
        }
    }
}

// Avengers detail view model communication
extension VillainsCoordinator: AvengerDetailsCoordinatorDelegate {
    
}
