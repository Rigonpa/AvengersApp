//
//  AvengersDetailDataModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 27/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol AvengerDetailsCoordinatorDelegate {
    
}

protocol AvengerDetailsViewDelegate {
    
}

class AvengerDetailsViewModel {
    
    // MARK: - Public properties
    var onPowerWasUpdated: (() -> Void)?
    
    var detailsViewModel: AvengerDetailsCellViewModel?
    
    var coordinatorDelegate: AvengerDetailsCoordinatorDelegate?
    var viewDelegate: AvengerDetailsViewDelegate?
    
    let dataProvider: DataProvider
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public methods
    func onWillShowHeroeDetails(_ heroe: Heroe) {
        detailsViewModel = AvengerDetailsCellViewModel(heroe: heroe)
    }
    
    func onWillShowVillainDetails(_ villain: Villain) {
        detailsViewModel = AvengerDetailsCellViewModel(villain: villain)
    }
    
    func heroesSection() -> Bool {
        return detailsViewModel?.heroe != nil
    }
    
    func navigationItemTitle() -> String? {
        detailsViewModel?.viewModelDelegate = self // ****** THE MOST IMPORTANT STEP I ALWAYS FORGET ******
        return detailsViewModel?.heroe != nil ? detailsViewModel?.heroe?.name : detailsViewModel?.villain?.name
    }
    
    // MARK: - Table view methods
    func heightCell(in position: IndexPath) -> Int {
        switch position.row {
            // ImageCell
            case 0:
                return 250
            // PowerCell
            case 1:
                return 60
            // CombatsCell
            case 2:
                return 95
            // Description Cell
            default:
                return 300
        }
    }
    
    func setDetailViewModel() -> AvengerDetailsCellViewModel? {
        return detailsViewModel
    }
}

// MARK: - Details cell view model communication
extension AvengerDetailsViewModel: DetailsCellViewModelDelegate {
    func onUpdatingPower(power: Int16, heroe: Heroe?, villain: Villain?) {
        if heroe != nil {
            // Needs to update heroe's power in coredata
            let heroes = dataProvider.loadHeroes()
            let heroeToUpdate = heroes?.filter{ $0.name == heroe?.name }
            guard let heroeUpdated = heroeToUpdate else { return }
            heroeUpdated[0].power = power
        } else {
            // Needs to update villain's power in coredata
            let villains = dataProvider.loadVillains()
            let villainToUpdate = villains?.filter{ $0.name == villain?.name }
            guard let villainUpdated = villainToUpdate else { return }
            villainUpdated[0].power = power
        }
        dataProvider.saveAvengerUpdates()
    }
    
    func onShowingPowerUpdated(heroe: Heroe?, villain: Villain?) -> Int16 {
        onPowerWasUpdated?()
        
        if heroe != nil {
            // Needs to update heroe's power in coredata
            let heroes = dataProvider.loadHeroes()
            let heroeToRetrieve = heroes?.filter{ $0.name == heroe?.name }
            guard let heroeRetrieved = heroeToRetrieve else { fatalError() }
            return heroeRetrieved[0].power
        } else {
            // Needs to update villain's power in coredata
            let villains = dataProvider.loadVillains()
            let villainToRetrive = villains?.filter{ $0.name == villain?.name }
            guard let villainRetrieved = villainToRetrive else { fatalError() }
            return villainRetrieved[0].power
        }
    }
}
