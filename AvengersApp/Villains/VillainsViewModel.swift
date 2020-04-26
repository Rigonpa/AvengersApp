//
//  VillainsViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol VillainsCoordinatorDelegate {
    
}

protocol VillainsViewDelegate {
    
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
        guard let initialVillains = dataProvider.provideInitialVillains() else { return } // Only executes once to store heroes data into coredata database.
        
        for each in 0...initialVillains.count - 1 {
            villainViewModels.append(VillainsCellViewModel(villain: initialVillains[each]))
//            each.viewModelDelegate = self
        }
    }
    
    // MARK: -Tableview methods
    func numberRows() -> Int {
        return villainViewModels.count
    }
    
    func oneVillainViewModel(_ index: IndexPath) -> VillainsCellViewModel? {
        return villainViewModels[index.row]
    }
}
