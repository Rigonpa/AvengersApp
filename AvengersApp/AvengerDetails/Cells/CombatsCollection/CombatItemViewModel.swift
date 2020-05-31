//
//  CombatItemViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 30/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

enum CombatState: Int {
    case finished, future
}

enum ViewedFrom: Int {
    case heroeSection, villainSection
}

class CombatItemViewModel {
    
    var combatState: CombatState?
    
    let combat: Combat?
    var viewedFrom: ViewedFrom
    var combatNumber: Int = 0
    init(combat: Combat?, viewedFrom: ViewedFrom, combatNumber: Int) {
        self.combat = combat
        self.viewedFrom = viewedFrom
        self.combatNumber = combatNumber
    }
}
