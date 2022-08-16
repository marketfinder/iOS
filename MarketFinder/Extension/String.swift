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
        let appleId = ""
        
        return "http://itunes.apple.com/lookup?id=\(appleId)"
    }
    
    // Localization
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
