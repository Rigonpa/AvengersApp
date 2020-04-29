//
//  CombatsViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol CombatsCoordinatorDelegate {
    func onChoosingHeroe()
    func onChoosingVillain()
}

protocol CombatsViewDelegate {
    func onshowingCombatsUpdates()
}

class CombatsViewModel {
    
    // MARK: - Public properties
    var combatViewModels = [CombatsCellViewModel]()
    
    var coordinatorDelegate: CombatsCoordinatorDelegate?
    var viewDelegate: CombatsViewDelegate?
    
    let dataProvider: DataProvider
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func fetchCombats() {
        combatViewModels = [] // Important so that cells do not duplicate
        guard let combats = dataProvider.loadCombats(), !combats.isEmpty else { return }
//        guard let combats = dataProvider.provideInicialCombats() else { return }
        for each in 0...combats.count - 1 {
            let combatCellViewModel = CombatsCellViewModel(combat: combats[each])
            combatCellViewModel.combat.combat_id = Int16(each + 1)
            combatCellViewModel.viewModelDelegate = self // I have again forgotten to assign view model delegate to myself
            combatViewModels.append(combatCellViewModel)
        }
        viewDelegate?.onshowingCombatsUpdates()
    }
    
    // MARK: - Public methods
    func onAvengerWasAssignedToCombat() {
        fetchCombats()
        showAllCombats()
    }
    
    func onNewCombatRequested() {
        guard let newCombat = dataProvider.createCombat() else { return }
//        newCombat.combat_id = Int16(combatViewModels.count + 1)
        dataProvider.saveAvengerUpdates()
        fetchCombats()
        showAllCombats()
    }
    
    func newCombatButtonEnabled() -> Bool {
        var enabled = false
        if !combatViewModels.isEmpty {
            for one in 0...combatViewModels.count - 1 {
                if combatViewModels[one].combat.winner != nil {
                    enabled = true
                }
            }
        } else {
            enabled = true
        }
        return enabled
    }
    
    // MARK: - Tableview methods
    func numberRows() -> Int {
        return combatViewModels.count
    }
    
    func oneCombatViewModel(_ index: IndexPath) -> CombatsCellViewModel? {
        let oneCombatViewModel = combatViewModels[index.row]
        return oneCombatViewModel
    }
}

// Combat cell view model communication
extension CombatsViewModel: CombatViewModelDelegate {
    func onChoosingVillain() {
        coordinatorDelegate?.onChoosingVillain()
    }
    
    func onChoosingHeroe() {
        coordinatorDelegate?.onChoosingHeroe()
    }
}
