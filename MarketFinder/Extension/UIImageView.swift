//
//  UIImage.swift
//  Karrot
//
//  Created by User on 2021/07/18.
//

import UIKit

extension UIImageView {

    // Load image to url
    func loadImage(absoluteUrl: String) -> Void {
        if let url:URL = URL(string: absoluteUrl) {
            do {
                let imageData:Data = try Data(contentsOf: url)
                self.image = UIImage(data: imageData)
            } catch {
                print(error.localizedDescription)
                self.loadFailed()
            }
        } else {
            self.loadFailed()
        }
    }
    
    // 로딩 실패 시
    private func loadFailed() -> Void {
        self.image = UIImage(named: "load_fail")
    }
}

extension UIImage {
    static func image(name: Image) -> UIImage? {
        return UIImage(named: name.rawValue) ?? UIImage(named: "load_fail")
    }
}
