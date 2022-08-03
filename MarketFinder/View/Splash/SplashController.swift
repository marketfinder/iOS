//
//  ViewController.swift
//  MarketFinder
//
//  Created by User on 2022/06/21.
//

import UIKit
import FontAwesome_swift

class SplashController: BaseController {

    // MARK: - Properties
    private let logoView:Logo = Logo()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(named: "DefaultColor")
        
        self.view.addSubviews(views: [
            self.logoView
        ])
        
        self.setupLayouts()
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.logoView.widthAnchor.constraint(equalToConstant: 150),
            self.logoView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}

