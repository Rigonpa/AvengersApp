//
//  VillainsCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 26/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation


protocol VillainsViewModelDelegate {
    func villainForFightSelected(villain: Villain)
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
    
    func villainForFightSelected(villain: Villain) {
        viewModelDelegate?.villainForFightSelected(villain: villain)
    }
}
