//
//  CoreDataDatabase.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataDatabase: LocalDataProvider {

    // MARK: - Common
    lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError()}
        return appDelegate.persistentContainer.viewContext
    }()
    
    func persist() {
        try? context.save()
    }

    // MARK: - Heroes persistance
    private var heroeEntity = "Heroe"
    
    func createHeroe() -> Heroe? {
        guard let entity = NSEntityDescription.entity(forEntityName: heroeEntity, in: context) else { return nil }
        return Heroe(entity: entity, insertInto: context)
    }
    
    func fetchHeroes() -> [Heroe]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: heroeEntity)
        let heroesData = try? context.fetch(fetchRequest) as? [Heroe]
        return heroesData
    }
    
    func deleteHeroe(with name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: heroeEntity)
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        let heroeToDelete = try? context.fetch(fetchRequest)
        heroeToDelete?.forEach { context.delete($0) }
        
        try? context.save()
    }
    
    //MARK: - Combats persistance
    private var combatEntity = "Combat"
    
    func createCombat() -> Combat? {
        guard let entity = NSEntityDescription.entity(forEntityName: combatEntity, in: context) else { return nil }
        return Combat(entity: entity, insertInto: context)
    }
    
    func fetchCombats() -> [Combat]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: combatEntity)
        let combatsData = try? context.fetch(fetchRequest) as? [Combat]
        return combatsData
    }
    
    func deleteCombat(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: combatEntity)
        fetchRequest.predicate = NSPredicate(format: "combat_id = %i", id)
        let combatToDelete = try? context.fetch(fetchRequest)
        combatToDelete?.forEach{ context.delete($0)}
        
        try? context.save()
    }
    
    
    // MARK: - Villains persistance
    private var villainEntity = "Villain"
    
    func createVillain() -> Villain? {
        guard let entity = NSEntityDescription.entity(forEntityName: villainEntity, in: context) else { return nil}
        return Villain(entity: entity, insertInto: context)
    }
    
    func fetchVillains() -> [Villain]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: villainEntity)
        let villainsData = try? context.fetch(fetchRequest) as? [Villain]
        return villainsData
    }
    
    func deleteVillain(with name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: villainEntity)
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        let villainToDelete = try? context.fetch(fetchRequest)
        villainToDelete?.forEach{ context.delete($0) }
        
        try? context.save()
    }
}
