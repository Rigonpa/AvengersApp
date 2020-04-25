//
//  HeroesViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol HeroesCoordinatorDelegate {
    
}

protocol HeroesViewDelegate {
    
}

class HeroesViewModel {
    
    var coordinatorDelegate: HeroesCoordinatorDelegate?
    var viewDelegate: HeroesViewDelegate?
    
    let dataProvider: DataProvider
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
}
