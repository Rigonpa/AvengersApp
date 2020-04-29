//
//  CombatsCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 28/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol CombatViewModelDelegate {
    func onChoosingHeroe()
    func onChoosingVillain()
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
    
    func onWillChooseHeroe() {
        viewModelDelegate?.onChoosingHeroe()
    }
    
    func onWillChooseVillain() {
        viewModelDelegate?.onChoosingVillain()
    }
}
