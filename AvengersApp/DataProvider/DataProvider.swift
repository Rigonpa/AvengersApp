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
    
    // MARK: - Heroes persistance
    func createHeroe() -> Heroe? {
        return localDataProvider?.createHeroe()
    }
    
    func loadHeroes() -> [Heroe]? {
        return localDataProvider?.fetchHeroes()
    }
    
    func deleteHeroe(with name: String) {
        localDataProvider?.deleteHeroe(with: name)
    }
    
    // MARK: - Combats persistance
    func createCombat() -> Combat? {
        return localDataProvider?.createCombat()
    }
    
    func loadCombats() -> [Combat]? {
        return localDataProvider?.fetchCombats()
    }
    
    func deleteCombat(with id: Int16) {
        localDataProvider?.deleteCombat(with: id)
    }
    
    // MARK: - Villains persistance
    func createVillain() -> Villain? {
        return localDataProvider?.createVillain()
    }
    
    func loadVillains() -> [Villain]? {
        return localDataProvider?.fetchVillains()
    }
    
    func deleteVillain(with name: String) {
        localDataProvider?.deleteVillain(with: name)
    }
    
    // MARK: - Initial characters data
    
    func provideInitialHeroes() -> [Heroe]? {
        localDataProvider?.provideInitialHeroesData()
    }
    
    func provideInitialVillains() -> [Villain]? {
        localDataProvider?.provideIntialVillainsData()
    }
}
