//
//  UIImage.swift
//  MarketFinder
//
//  Created by User on 2022/08/11.
//

import UIKit

extension UIImage {
    
    static func image(image: Image) -> UIImage {
        return UIImage(named: image.rawValue) ?? UIImage()
    }
}
