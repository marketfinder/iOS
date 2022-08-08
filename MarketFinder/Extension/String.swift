//
//  String.swift
//  MarketFinder
//
//  Created by User on 2022/08/04.
//

import Foundation

extension String {
    
    // Application URL
    static var appUrl: String {
        return "https://apps.apple.com/us/app/naver-map-navigation/id311867728?uo=4&at=11l6hc&app=itunes&ct=fnd"
    }
    
    // Localization
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
