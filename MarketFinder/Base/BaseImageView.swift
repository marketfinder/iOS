//
//  BaseImageView.swift
//  Supermarket
//
//  Created by User on 2021/07/05.
//

import UIKit
import FontAwesome_swift

class BaseImageView: UIImageView {
    
    // MARK: - Life Cycle
    init(image:Image? = nil, contentMode: UIView.ContentMode = .scaleToFill) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = contentMode
        
        if let image:Image = image {
            self.image = UIImage(named: image.rawValue)
        }
    }
    
    init(name: FontAwesome, style: FontAwesomeStyle, textColor: UIColor, width: CGFloat, height: CGFloat) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = contentMode
        
        self.image = UIImage.fontAwesomeIcon(name: name, style: style, textColor: textColor, size: CGSize(width: width, height: height))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
}
