//
//  UIButton+Extension.swift
//  QQMProjectSwift
//
//  Created by liupuyan on 2017/5/27.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setBackgroundColor(_ color: UIColor?, for state: UIControlState) {
        self.setBackgroundImage(UIButton.getImage(color: color!), for: state)
    }
    
    class func getImage(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
