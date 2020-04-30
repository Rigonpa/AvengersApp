//
//  LocalDataProvider.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol LocalDataProvider {

    func persist()
    func deleteAll()
    
    // Heroes
    func createHeroe() -> Heroe?
    func fetchHeroes() -> [Heroe]?
    func deleteHeroe(withName: String)
    func provideInitialHeroesData() -> [Heroe]?

    // Combats
    func createCombat() -> Combat?
    func fetchCombats() -> [Combat]?
    func deleteCombat(withId: Int16)
    func provideInitialCombatsData() -> [Combat]?

    // Villains
    func createVillain() -> Villain?
    func fetchVillains() -> [Villain]?
    func deleteVillain(withName: String)
    func provideInitialVillainsData() -> [Villain]?
}
