//
//  VillainsViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol VillainsCoordinatorDelegate {
    func onDetailRequestedFor(_ villain: Villain)
    func onVillainWasAssignedToCombat()
}

protocol VillainsViewDelegate {
    func onVillainPowerWasUpdated()
}

class VillainsViewModel {
    
    // MARK: - Public properties
    var villainViewModels = [VillainsCellViewModel]()
    
    var coordinatorDelegate: VillainsCoordinatorDelegate?
    var viewDelegate: VillainsViewDelegate?
    
    let dataProvider: DataProvider
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Lifecycle methods
    func viewDidLoad() {
        var villains: [Villain]?
        let villainsSaved = dataProvider.loadVillains()
        if villainsSaved != [] {
            // Only executes once to store villains data into coredata database.
            villains = []
            villains = villainsSaved
        } else {
            // From second time always executes this section
            guard let initialVillains = dataProvider.provideInitialVillains() else { return }
            villains = initialVillains
            dataProvider.saveAvengerUpdates()
        }
        
        for each in 0...villains!.count - 1 {
            let villainViewModel = VillainsCellViewModel(villain: villains![each])
            villainViewModels.append(villainViewModel)
            villainViewModel.viewModelDelegate = self
        }
    }
    
    // MARK: - Tableview methods
    func didSelectRow(_ index: IndexPath) {
        coordinatorDelegate?.onDetailRequestedFor(villainViewModels[index.row].villain)
    }
    
    func numberRows() -> Int {
        return villainViewModels.count
    }
    
    func oneVillainViewModel(_ index: IndexPath) -> VillainsCellViewModel? {
        return villainViewModels[index.row]
    }
    
    // MARK: - Detail view model communication
    func onPowerWasUpdated() {
        villainViewModels = []
        guard let villainsSaved = dataProvider.loadVillains() else { return }
        for each in 0...villainsSaved.count - 1 {
            villainViewModels.append(VillainsCellViewModel(villain: villainsSaved[each]))
        }
        viewDelegate?.onVillainPowerWasUpdated()
    }
}

// MARK: - Cell view model communication
extension VillainsViewModel: VillainsViewModelDelegate {
    func villainForFightSelected(villain: Villain) {
        guard let combats = dataProvider.loadCombats() else { return }
        let combat = combats.filter{ $0.villain == nil }
        combat[0].villain = villain
        dataProvider.saveAvengerUpdates()
        
        coordinatorDelegate?.onVillainWasAssignedToCombat()
    }
}
