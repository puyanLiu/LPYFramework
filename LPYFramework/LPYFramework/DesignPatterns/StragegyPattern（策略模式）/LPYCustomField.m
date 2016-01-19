//
//  LPYCustomField.m
//  LPYFramework
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYCustomField.h"

@implementation LPYCustomField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.frame.size.height)];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    self.font = [UIFont fontWithName:@"Avenir-Book" size:12.f];
    self.layer.borderWidth = 0.5f;
}

- (BOOL)validate {
    return [self.validator validateInput:self];
}

@end
