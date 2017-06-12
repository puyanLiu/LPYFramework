//
//  UIView+Extension.swift
//  QQMProjectSwift
//
//  Created by liupuyan on 2017/5/12.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /**
     * 高度
     */
    var height_: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var frame: CGRect = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    /**
     * 宽度
     */
    var width_: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var frame: CGRect = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    var x_: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var frame: CGRect = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y_: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var frame: CGRect = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var centerX_: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var center: CGPoint = self.center
            center.x = newValue
            self.center = center
        }
    }
    var centerY_: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var center: CGPoint = self.center
            center.y = newValue
            self.center = center
        }
    }
    var size_: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var frame: CGRect = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
}


// MARK: - layer
extension UIView {
    class func createGradientLayer(frame: CGRect, startColor: UIColor, endColor: UIColor, gradientAngle: CGFloat) -> CAGradientLayer {
        return createGradientLayer(frame: frame, startColor: startColor, endColor: endColor, gradientAngle: gradientAngle, startPoint: CGPoint(x: 1, y: 1), endPoint: CGPoint(x: 0, y: tan(gradientAngle)))
    }
    
    class func createGradientLayer(frame: CGRect, startColor: UIColor, endColor: UIColor, gradientAngle: CGFloat, startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        if gradientAngle > 0 {
            let l: NSNumber = NSNumber(value: Float(tan(gradientAngle)))
            gradientLayer.locations = [l]
        }
        let startColor = startColor.cgColor
        let endColor = endColor.cgColor
        gradientLayer.colors = [startColor, endColor]
        return gradientLayer
    }
}
