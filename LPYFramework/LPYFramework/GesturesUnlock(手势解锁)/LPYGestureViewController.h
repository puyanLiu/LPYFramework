//
//  LPYGestureViewController.h
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LPYGestureViewControllerTypeSetting = 1,
    LPYGestureViewControllerTypeLogin
} LPYGestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget
}buttonTag;

@interface LPYGestureViewController : UIViewController
//  控制器来源
@property (nonatomic, assign) LPYGestureViewControllerType type;
@end
