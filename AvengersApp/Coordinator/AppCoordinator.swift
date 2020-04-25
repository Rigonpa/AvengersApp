//
//  AppCoordinator.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let dataProvider: DataProvider = {
        let dataProvider = DataProvider()
        return dataProvider
    }()
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        
    }
    
    override func finish() {}
}
