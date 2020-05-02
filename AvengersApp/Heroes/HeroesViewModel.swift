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
    func onHeroeWasAssignedToCombat()
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
        guard let heroesToShow = heroes else { return }
        for each in 0...heroesToShow.count - 1 {
            let heroeCellViewModel = HeroesCellViewModel(heroe: heroesToShow[each])
            heroeCellViewModel.viewModelDelegate = self // ****** THE MOST IMPORTANT STEP I ALWAYS FORGET ******
            heroeViewModels.append(heroeCellViewModel)
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
            let heroeCellViewModel = HeroesCellViewModel(heroe: heroesSaved[each])
            heroeViewModels.append(heroeCellViewModel)
        }
        viewDelegate?.onHeroePowerWasUpdated()
    }
}

// MARK: - Heroes cell view model communication
extension HeroesViewModel: HeroesViewModelDelegate {
    
    func heroeForFightSelected(heroe: Heroe) {
        guard let combats = dataProvider.loadCombats() else { return }
        showAllCombats()
        
        let combat = combats.filter{ $0.heroe == nil }
        
        combat[0].heroe = heroe
        dataProvider.saveAvengerUpdates()
        showAllCombats()
        coordinatorDelegate?.onHeroeWasAssignedToCombat()
    }
}
