//
//  UINavigationController+Extension.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 26/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        guard let context = UIGraphicsGetCurrentContext() else { fatalError() }
        self.setFill()
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { fatalError()}
        UIGraphicsEndImageContext()
        return image
    }
}
