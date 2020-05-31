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
    
    var detailsViewModel: [CellViewModel] = []
    
    var coordinatorDelegate: AvengerDetailsCoordinatorDelegate?
    var viewDelegate: AvengerDetailsViewDelegate?
    
    let dataProvider: DataProvider
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public methods
    func onWillShowHeroeDetails(_ heroe: Heroe) {
        detailsViewModel.append(ImageCellViewModel(heroe: heroe))
        detailsViewModel.append(PowerCellViewModel(heroe: heroe))
        detailsViewModel.append(CombatsTrackCellViewModel(heroe: heroe))
        detailsViewModel.append(DescriptionCellViewModel(heroe: heroe))
    }
    
    func onWillShowVillainDetails(_ villain: Villain) {
        detailsViewModel.append(ImageCellViewModel(villain: villain))
        detailsViewModel.append(PowerCellViewModel(villain: villain))
        detailsViewModel.append(CombatsTrackCellViewModel(villain: villain))
        detailsViewModel.append(DescriptionCellViewModel(villain: villain))
    }
    
    func heroesSection() -> Bool {
        let imageCellViewModel = detailsViewModel[0] as? ImageCellViewModel
        return imageCellViewModel?.heroe != nil
    }
    
    func navigationItemTitle() -> String? {
        let powerCellViewModel = detailsViewModel[1] as? PowerCellViewModel
        powerCellViewModel?.viewModelDelegate = self // ****** THE MOST IMPORTANT STEP I ALWAYS FORGET ******
        return powerCellViewModel?.heroe != nil ? powerCellViewModel?.heroe?.name : powerCellViewModel?.villain?.name
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
    
    func setDetailViewModel(indexPath: IndexPath) -> CellViewModel? {
        return detailsViewModel[indexPath.row]
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
