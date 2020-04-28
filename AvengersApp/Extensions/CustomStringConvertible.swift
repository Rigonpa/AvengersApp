//
//  CustomStringConvertible.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 28/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

extension Heroe {
    public override var description: String {
        return "\n\n Heroe name: \(name!)\n Power: \(power)\n Profile image name: \(profile_image!)"
    }
}

extension Villain {
    public override var description: String {
        return "\n\n Villain name: \(name!)\n Power: \(power)\n Profile image name: \(profile_image!)"
    }
}
