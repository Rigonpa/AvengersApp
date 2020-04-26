//
//  VillainsCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 26/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation


protocol VillainsViewModelDelegate {
    
}

protocol VillainsCellViewDelegate {
    
}


class VillainsCellViewModel {
    
    var viewModelDelegate: VillainsViewModelDelegate?
    var viewDelegate: VillainsCellViewDelegate?
    
    let villain: Villain
    init(villain: Villain) {
        self.villain = villain
    }
    
}
