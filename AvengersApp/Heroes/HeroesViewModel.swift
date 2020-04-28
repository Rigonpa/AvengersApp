//
//  HeroesViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol HeroesCoordinatorDelegate {
    func onDetailRequestedFor(_ heroe: Heroe)
}

protocol HeroesViewDelegate {
    func onHeroePowerWasUpdated()
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
        
        var heroes: [Heroe]?
        let heroesSaved = dataProvider.loadHeroes()
        if heroesSaved != [] {
            // Only executes once to store heroes data into coredata database.
            heroes = []
            heroes = heroesSaved
        } else {
            // From second time always executes this section
            guard let initialHeroes = dataProvider.provideInitialHeroes() else { return }
            heroes = initialHeroes
            dataProvider.saveAvengerUpdates()
        }
        
        for each in 0...heroes!.count - 1 {
            heroeViewModels.append(HeroesCellViewModel(heroe: heroes![each]))
//            each.viewModelDelegate = self
        }
    }
    
    // MARK: - Tableview methods
    func didSelectRow(_ index: IndexPath) {
        coordinatorDelegate?.onDetailRequestedFor(heroeViewModels[index.row].heroe)
    }
    
    func numberRows() -> Int {
        return heroeViewModels.count
    }
    
    func oneHeroeViewModel(_ index: IndexPath) -> HeroesCellViewModel? {
        return heroeViewModels[index.row]
    }
    
    // MARK: - Detail view model communication
    func onPowerWasUpdated() {
        heroeViewModels = []
        guard let heroesSaved = dataProvider.loadHeroes() else { return }
        for each in 0...heroesSaved.count - 1 {
            heroeViewModels.append(HeroesCellViewModel(heroe: heroesSaved[each]))
        }
        viewDelegate?.onHeroePowerWasUpdated()
    }
}
