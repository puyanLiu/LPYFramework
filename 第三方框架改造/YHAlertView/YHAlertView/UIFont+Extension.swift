//
//  UIFont+Extension.swift
//  QQMProjectSwift
//
//  Created by liupuyan on 2017/6/6.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import Foundation
import UIKit

public enum QQMFontWeight {
    case thin
    case regular
    case medium
    case bold
}

extension UIFont {
    class func qqmSystemFont(ofSize size: CGFloat, weight: QQMFontWeight) -> UIFont {
        if #available(iOS 8.2, *) {
            switch weight {
                case .thin:
                    return UIFont.systemFont(ofSize: size, weight: UIFontWeightThin)
                case .regular:
                    return UIFont.systemFont(ofSize: size, weight: UIFontWeightRegular)
                case .medium:
                    return UIFont.systemFont(ofSize: size, weight: UIFontWeightMedium)
                case .bold:
                    return UIFont.systemFont(ofSize: size, weight: UIFontWeightBold)
            }
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}
