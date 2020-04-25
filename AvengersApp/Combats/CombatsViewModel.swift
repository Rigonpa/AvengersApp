//
//  CombatsViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol CombatsCoordinatorDelegate {
    
}

protocol CombatsViewDelegate {
    
}

class CombatsViewModel {
    
    var coordinatorDelegate: CombatsCoordinatorDelegate?
    var viewDelegate: CombatsViewDelegate?
    
    let dataProvider: DataProvider
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
}
