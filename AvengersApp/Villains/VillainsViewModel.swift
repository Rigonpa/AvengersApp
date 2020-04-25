//
//  VillainsViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol VillainsCoordinatorDelegate {
    
}

protocol VillainsViewDelegate {
    
}

class VillainsViewModel {
    
    var coordinatorDelegate: VillainsCoordinatorDelegate?
    var viewDelegate: VillainsViewDelegate?
    
    let dataProvider: DataProvider
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
}
