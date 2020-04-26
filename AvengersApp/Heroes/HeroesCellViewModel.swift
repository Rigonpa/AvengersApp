//
//  HeroesCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 26/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol HeroesViewModelDelegate {
    
}

protocol HeroesCellViewDelegate {
    
}

class HeroesCellViewModel {
    
    var viewModelDelegate: HeroesViewModelDelegate?
    var viewDelegate: HeroesCellViewDelegate?
    
    let heroe: Heroe
    init(heroe: Heroe) {
        self.heroe = heroe
    }
    
    
}
