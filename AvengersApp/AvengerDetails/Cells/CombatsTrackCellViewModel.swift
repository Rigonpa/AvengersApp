//
//  CombatsTrackCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 30/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatsTrackCellViewModel: CellViewModel {
    // MARK: - Properties
    private var combatsTrack = [CombatItemViewModel]()
    
    var heroe: Heroe?
    var villain: Villain?
           
    convenience init(heroe: Heroe) {
        self.init()
        self.heroe = heroe
        
        guard let combats = heroe.combats?.allObjects as? [Combat] else { return }
        let sortedCombats = combats.sorted { (c1, c2) -> Bool in
            return c1.combat_id < c2.combat_id
        }
        if !sortedCombats.isEmpty {
            for each in 0...sortedCombats.count - 1 {
                combatsTrack.append(CombatItemViewModel(combat: sortedCombats[each], viewedFrom: .heroeSection, combatNumber: each + 1))
            }
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .heroeSection, combatNumber: sortedCombats.count + 1))
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .heroeSection, combatNumber: sortedCombats.count + 2))
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .heroeSection, combatNumber: sortedCombats.count + 3))
        } else {
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .heroeSection, combatNumber: 1))
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .heroeSection, combatNumber: 2))
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .heroeSection, combatNumber: 3))
        }
    }
    
    convenience init(villain: Villain) {
        self.init()
        self.villain = villain
        
        guard let combats = villain.combats?.allObjects as? [Combat] else { return }
        let sortedCombats = combats.sorted { (c1, c2) -> Bool in
            return c1.combat_id < c2.combat_id
        }
        if !sortedCombats.isEmpty {
            for each in 0...sortedCombats.count - 1 {
                combatsTrack.append(CombatItemViewModel(combat: sortedCombats[each], viewedFrom: .villainSection, combatNumber: each + 1))
            }
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .villainSection, combatNumber: sortedCombats.count + 1))
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .villainSection, combatNumber: sortedCombats.count + 2))
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .villainSection, combatNumber: sortedCombats.count + 3))
        } else {
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .villainSection, combatNumber: 1))
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .villainSection, combatNumber: 2))
            combatsTrack.append(CombatItemViewModel(combat: nil, viewedFrom: .villainSection, combatNumber: 3))
        }
    }
    
    func itemSize() -> CGSize {
        return CGSize(width: 125, height: 95)
    }
    
    func numberOfItems() -> Int {
        return combatsTrack.count
    }

    func viewModel(indexPath: IndexPath) -> CombatItemViewModel? {
        guard !combatsTrack.isEmpty, indexPath.item < combatsTrack.count else { return nil }
        let combatItemViewModel = combatsTrack[indexPath.item]
        
        if combatsTrack[indexPath.item].combat != nil {
            combatItemViewModel.combatState = .finished
        } else {
            combatItemViewModel.combatState = .future
        }
        return combatItemViewModel
    }
}
