//
//  UILabel+Extension.m
//  QQMProject
//
//  Created by admin on 15/10/24.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (void)setAppearanceFont:(UIFont *)appearanceFont
{
    if(appearanceFont)
    {
        [self setFont:appearanceFont];
    }
}

- (UIFont *)appearanceFont
{
    return self.font;
}
@end
