//
//  AppDelegate.swift
//  MarketFinder
//
//  Created by User on 2022/06/21.
//

import UIKit

enum AppVersion {
    case required
    case optional
    case latest
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: .zero)
        self.window?.rootViewController = BaseNavigationController(rootViewController: SplashController())
        self.window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func currentVersion() -> String {
        return ""
    }
    
    func latestVersion() -> String? {
        guard let url:URL = URL(string: String.appUrl),
              let data:Data = try? Data(contentsOf: url),
              let json:[String:Any] = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any],
              let result:[[String:Any]] = json["result"] as? [[String: Any]],
              let appStoreVersion:String = result[0]["version"] as? String else {
            return nil
        }
        
        return appStoreVersion
    }
    
    func compareVersion() -> AppVersion {
        let currentVer:String = self.currentVersion()
        let latestVer:String = self.latestVersion() ?? "1.0.0"
        let compareResult:ComparisonResult = currentVer.compare(latestVer, options: .numeric)
        
        if compareResult == .orderedAscending {
            let minimumVer:String = ""
            let compareResult = minimumVer.compare(latestVer, options: .numeric)
            
            return compareResult == .orderedDescending ? .optional : .required
        }
        
        return .latest
    }
}

