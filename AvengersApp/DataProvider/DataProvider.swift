//
//  DataProvider.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class DataProvider {
    
    let localDataProvider: LocalDataProvider?
    let remoteDataProvider: RemoteDataProvider?
    
    init() {
        localDataProvider = CoreDataDatabase()
        remoteDataProvider = RemoteDatabase()
    }
    
    // MARK: - Common
    func saveAvengerUpdates() {
        localDataProvider?.persist()
    }
    
    func deleteAll() {
        localDataProvider?.deleteAll()
    }
    
    // MARK: - Heroes persistance
    func createHeroe() -> Heroe? {
        return localDataProvider?.createHeroe()
    }
    
    func loadHeroes() -> [Heroe]? {
        return localDataProvider?.fetchHeroes()
    }
    
    func deleteHeroe(withName name: String) {
        localDataProvider?.deleteHeroe(withName: name)
    }
    
    // MARK: - Combats persistance
    func createCombat() -> Combat? {
        return localDataProvider?.createCombat()
    }
    
    func loadCombats() -> [Combat]? {
        return localDataProvider?.fetchCombats()
    }
    
    func deleteCombat(withId id: Int16) {
        localDataProvider?.deleteCombat(withId: id)
    }
    
    // MARK: - Villains persistance
    func createVillain() -> Villain? {
        return localDataProvider?.createVillain()
    }
    
    func loadVillains() -> [Villain]? {
        return localDataProvider?.fetchVillains()
    }
    
    func deleteVillain(withName name: String) {
        localDataProvider?.deleteVillain(withName: name)
    }
    
    // MARK: - Initial characters data
    
    func provideInitialHeroes() -> [Heroe]? {
        localDataProvider?.provideInitialHeroesData()
    }
    
    func provideInitialVillains() -> [Villain]? {
        localDataProvider?.provideInitialVillainsData()
    }
    
    func provideInicialCombats() -> [Combat]? {
        return localDataProvider?.provideInitialCombatsData()
    }
}
