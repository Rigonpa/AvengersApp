//
//  CombatsViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol CombatsCoordinatorDelegate {
    
}

protocol CombatsViewDelegate {
    
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
    
    func viewDidLoad() {
//        guard let combats = dataProvider.loadCombats() else { return }
        guard let combats = dataProvider.provideInicialCombats() else { return }
        for each in 0...combats.count - 1 {
            combatViewModels.append(CombatsCellViewModel(combat: combats[each]))
        }
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
