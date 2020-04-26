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

    // Heroes
    func createHeroe() -> Heroe?
    func fetchHeroes() -> [Heroe]?
    func deleteHeroe(with: String)

    // Combats
    func createCombat() -> Combat?
    func fetchCombats() -> [Combat]?
    func deleteCombat(with: Int16)

    // Villains
    func createVillain() -> Villain?
    func fetchVillains() -> [Villain]?
    func deleteVillain(with: String)
}
