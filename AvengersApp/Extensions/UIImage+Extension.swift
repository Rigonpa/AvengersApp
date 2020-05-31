//
//  UIImage+Extension.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

extension Coordinator {
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { fatalError() }
        UIGraphicsEndImageContext()

        return newImage
    }
}

class CustomView: UIView {
    let myContentView = UIView()
    let cornerRadius: CGFloat
    var shadowColor: CGColor
    
    init(cornerRadius: CGFloat,
        shadowColor: CGColor,
        xOffset: Int,
        yOffset: Int,
        alpha: Float,
        shadowRadius: CGFloat) {
        
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        super.init(frame: .zero)
        
        // 1. Parent view has shadow and corner radius/border
        layer.shadowColor = shadowColor
        layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
        layer.shadowOpacity = alpha
        layer.shadowRadius = shadowRadius
        layer.cornerRadius = cornerRadius
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        addSubview(myContentView)
        myContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            myContentView.topAnchor.constraint(equalTo: topAnchor),
            myContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myContentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // 2. Child/content view has corner radius
        myContentView.layer.cornerRadius = cornerRadius
        myContentView.layer.masksToBounds = true
    }
}
