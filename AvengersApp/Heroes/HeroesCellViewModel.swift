//
//  HeroesCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 26/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol HeroesViewModelDelegate {
    func heroeForFightSelected(heroe: Heroe)
}

protocol HeroesCellViewModelViewDelegate: class {
    
}

class HeroesCellViewModel {
    
    var viewModelDelegate: HeroesViewModelDelegate?
    weak var viewDelegate: HeroesCellViewModelViewDelegate?
    
    let heroe: Heroe
    init(heroe: Heroe) {
        self.heroe = heroe
    }
    
    func heroeForFightSelected(heroe: Heroe) {
        viewModelDelegate?.heroeForFightSelected(heroe: heroe)
    }
}
