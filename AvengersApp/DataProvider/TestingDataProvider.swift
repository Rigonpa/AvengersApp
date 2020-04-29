//
//  TestingDataProvider.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 28/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

extension HeroesViewModel {
    
    func showAllCombats() {
        let combats = dataProvider.loadCombats()!
        print(combats.description)
    }
    
    func showAllHeroes() {
        let heroes = dataProvider.loadHeroes()!
        print(heroes.description)
    }
    
//    func showAllVillains() {
//        print(dataProvider.loadVillains()!)
//    }
    
    func deleteAll() {
        dataProvider.deleteAll()
    }
}

extension VillainsViewModel {
    
    func showAllCombats() {
        let combats = dataProvider.loadCombats()!
        print(combats.description)
    }
    
//    func showAllHeroes() {
//        print(dataProvider.loadHeroes()!)
//    }
    
    func showAllVillains() {
        let villains = dataProvider.loadVillains()!
        print(villains.description)
    }
    
    func deleteAll() {
        dataProvider.deleteAll()
    }
}

extension AvengerDetailsViewModel {
    
    func showAllCombats() {
        let combats = dataProvider.loadCombats()!
        print(combats.description)
    }
    
    func showAllHeroes() {
        let heroes = dataProvider.loadHeroes()!
        print(heroes.description)
    }
    
    func showAllVillains() {
        let villains = dataProvider.loadVillains()!
        print(villains.description)
    }
    
    func deleteAll() {
        dataProvider.deleteAll()
    }
}

extension CombatsViewModel {
    func showAllCombats() {
        let combats = dataProvider.loadCombats()!
        print(combats.description)
    }
    
    func deleteAll() {
        dataProvider.deleteAll()
    }
}
