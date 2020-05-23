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
        guard let combats = dataProvider.loadCombats(), !combats.isEmpty else {
            viewDelegate?.onshowingCombatsUpdates()
            return
        }
//        guard let combats = dataProvider.provideInicialCombats() else { return }
        for each in 0...combats.count - 1 {
            let combatCellViewModel = CombatsCellViewModel(combat: combats[each])
            combatCellViewModel.viewModelDelegate = self // I have again forgotten to assign view model delegate to combatsViewModel
            combatViewModels.append(combatCellViewModel)
        }
        viewDelegate?.onshowingCombatsUpdates()
    }
    
    // MARK: - Public methods
    func onAvengerWasAssignedToCombat() {
        fetchCombats()
//        showAllCombats()
    }
    
    func onNewCombatRequested() {
        guard let newCombat = dataProvider.createCombat() else { return }
        newCombat.combat_id = Int16(combatViewModels.count + 1)
        dataProvider.saveAvengerUpdates()
        fetchCombats()
//        showAllCombats()
    }
    
    func newCombatButtonEnabled() -> Bool {
        var enabled = true
        if !combatViewModels.isEmpty {
            for one in 0...combatViewModels.count - 1 {
                if combatViewModels[one].combat.winner == nil {
                    enabled = false
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
    
    func deleteCombat(at index: IndexPath) {
        guard let combats = dataProvider.loadCombats() else { return }
        let combatToDelete = combats.filter{ $0.combat_id == combatViewModels[index.row].combat.combat_id }
        combatToDelete.forEach{ dataProvider.deleteCombat(withId: $0.combat_id) }
        dataProvider.saveAvengerUpdates()
        
        guard let newCombats = dataProvider.loadCombats(), !newCombats.isEmpty else {
            dataProvider.saveAvengerUpdates()
            fetchCombats()
            return
        }
        
        for each in 0...newCombats.count - 1 {
            newCombats[each].combat_id = Int16(each + 1)
        }
        dataProvider.saveAvengerUpdates()
        fetchCombats()
        
    }
}

// MARK: - Combat cell view model communication
extension CombatsViewModel: CombatViewModelDelegate {
    func onStartingCombat() {
        sleep(3)
        guard let combats = dataProvider.loadCombats() else { return }
//        showAllCombats()
        let combatNow = combats.filter{ $0.winner == nil }
        let combat = combatNow[0]
        
        guard let heroe = combat.heroe, let villain = combat.villain else { return }
        let powerHeroeFighting = Int(heroe.power)
        let powerVillainFighting = Int(villain.power)
        
        if powerHeroeFighting > powerVillainFighting {
            // Heroe wins
            combat.winner = heroe.name
        } else if powerHeroeFighting < powerVillainFighting {
            // Villain wins
            combat.winner = villain.name
        } else {
            // Tied
            if heroe.name!.count > villain.name!.count {
                combat.winner = heroe.name
            } else if heroe.name!.count < villain.name!.count {
                combat.winner = villain.name
            } else {
                combat.winner = heroe.name
            }
        }
        dataProvider.saveAvengerUpdates()
        fetchCombats()
    }
    
    func onChoosingVillain() {
        coordinatorDelegate?.onChoosingVillain()
    }
    
    func onChoosingHeroe() {
        coordinatorDelegate?.onChoosingHeroe()
    }
}
