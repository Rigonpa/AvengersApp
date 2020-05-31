//
//  ImageCellViewModel.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 30/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class ImageCellViewModel: CellViewModel {
    // MARK: - Public properties
       var heroe: Heroe?
       var villain: Villain?
              
       convenience init(heroe: Heroe) {
           self.init()
           self.heroe = heroe
       }
       
       convenience init(villain: Villain) {
           self.init()
           self.villain = villain
       }
}
