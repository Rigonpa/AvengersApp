//
//  AvengersDetailCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 27/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol DetailsCellViewModelDelegate {
    func onUpdatingPower(power: Int16, heroe: Heroe?, villain: Villain?)
//    func onShowingPowerUpdated(heroe: Heroe?, villain: Villain?) -> (Heroe?, Villain?)
    func onShowingPowerUpdated(heroe: Heroe?, villain: Villain?) -> Int16
}

class AvengerDetailsCellViewModel {
    
    var heroe: Heroe?
    var villain: Villain?
    
    var viewModelDelegate: DetailsCellViewModelDelegate?
    
    convenience init(heroe: Heroe) {
        self.init()
        self.heroe = heroe
    }
    
    convenience init(villain: Villain) {
        self.init()
        self.villain = villain
    }
    
    func updatePower(newPower: Int16, heroe: Heroe?, villain: Villain?) {
//        viewModelDelegate?.onUpdatingPower(power: newPower, heroe: heroe, villain: villain)
        
        viewModelDelegate?.onUpdatingPower(power: newPower, heroe: heroe, villain: villain)
    }
    
    func showPowerUpdated(heroe: Heroe?, villain: Villain?) -> Int16? {
        guard let powerToUpdate = viewModelDelegate?.onShowingPowerUpdated(heroe: heroe, villain: villain) else { return nil }
        return powerToUpdate
    }
}
