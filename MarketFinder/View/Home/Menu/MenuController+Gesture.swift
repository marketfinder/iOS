//
//  MenuController+Gesture.swift
//  MarketFinder
//
//  Created by User on 2022/08/16.
//

import UIKit

extension MenuController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return false
    }
}
