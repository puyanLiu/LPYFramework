//
//  DataConst.swift
//  QQMProjectSwift
//
//  Created by liupuyan on 2017/5/12.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import Foundation
import UIKit

// 屏幕尺寸相关
let QQMScreenBounds = UIScreen.main.bounds
let QQMScreenWidth = QQMScreenBounds.size.width
let QQMScreenHeight = QQMScreenBounds.size.height
let QQMKeyWindow = (UIApplication.shared.keyWindow != nil ? UIApplication.shared.keyWindow : UIApplication.shared.delegate?.window)

// 每次加载的数据条数
let PageCount: Int = 10

// 表格行高
let tableViewCellH: CGFloat = 48.0

// 边框
let QQMGlobalMargin10: CGFloat = 10
let QQMGlobalMargin15: CGFloat = 15

// 状态栏高
let QQMStatusH: CGFloat = 20.0

// 导航控制器高度
let QQMNavH: CGFloat = 44.0

// 底部控制器高度
let QQMTabH: CGFloat = 49.0

// iPhone6高度
let QQMiPhone6: CGFloat = 375

// collectionCellH
let CollectionHotForCellH: CGFloat = 145.0
let CollectionPopularLotteryCellH: CGFloat = 130.0

// 手机类型
let IPHONE4Width: CGFloat = 320
let IPHONE6Width: CGFloat = 375
let IPHONE6PWidth: CGFloat = 414
let IPHONE4 = (QQMScreenWidth == IPHONE4Width && QQMScreenHeight == 480)
let IPHONE5 = (QQMScreenWidth == IPHONE4Width && QQMScreenHeight == 568)
let IPHONE6 = (QQMScreenWidth == IPHONE6Width)
let IPHONE6P = (QQMScreenWidth > IPHONE6Width)

// story名称
let LoginStoryboard: String = "Login"
let HomeStoryboard: String = "Home"


