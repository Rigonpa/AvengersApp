//
//  HeroesViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol HeroesCoordinatorDelegate {
    
}

protocol HeroesViewDelegate {
    
}

class HeroesViewModel {
    
    // MARK: - Public properties
    var heroeViewModels = [HeroesCellViewModel]()
    
    var coordinatorDelegate: HeroesCoordinatorDelegate?
    var viewDelegate: HeroesViewDelegate?
    
    let dataProvider: DataProvider
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Lifecycle methods
    func viewDidLoad() {
        guard let initialHeroes = dataProvider.provideInitialHeroes() else { return } // Only executes once to store heroes data into coredata database.
        
        for each in 0...initialHeroes.count - 1 {
            heroeViewModels.append(HeroesCellViewModel(heroe: initialHeroes[each]))
//            each.viewModelDelegate = self
        }
    }
    
    // MARK: - Tableview methods
    func numberRows() -> Int {
        return heroeViewModels.count
    }
    
    func oneHeroeViewModel(_ index: IndexPath) -> HeroesCellViewModel? {
        return heroeViewModels[index.row]
    }
}
