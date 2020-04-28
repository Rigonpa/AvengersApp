//
//  CombatsCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 28/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol CombatViewModelDelegate {
    
}

protocol CombatViewDelegate {
    
}

class CombatsCellViewModel {
    
    var viewModelDelegate: CombatViewModelDelegate?
    var viewDelegate: CombatViewDelegate?
    
    let combat: Combat
    init(combat: Combat) {
        self.combat = combat
    }
    
    
}
