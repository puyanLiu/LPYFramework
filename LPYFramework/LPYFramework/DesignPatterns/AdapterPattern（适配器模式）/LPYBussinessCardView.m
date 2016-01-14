
//
//  LPYBussinessCardView.m
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBussinessCardView.h"

@interface LPYBussinessCardView ()
// nameLabel
@property (nonatomic, strong) UILabel *nameLabel;
// lineView
@property (nonatomic, strong) UIView *lineView;
// phoneNumberLabel
@property (nonatomic, strong) UILabel *phoneNumberLabel;
@end

@implementation LPYBussinessCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5f;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(5, 5);
    self.layer.shadowRadius = 1.f;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 25)];
    self.nameLabel.font = [UIFont fontWithName:@"Avenir-Light" size:20.0F];
    [self addSubview:self.nameLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 200, 5)];
    [self addSubview:self.lineView];
    
    self.phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(41, 105, 150, 20)];
    self.phoneNumberLabel.textAlignment = NSTextAlignmentRight;
    self.phoneNumberLabel.font = [UIFont fontWithName:@"AvenirNext-UltraLightItalic" size:16.f];
    [self addSubview:self.phoneNumberLabel];
}

- (void)setBussinessCardData:(id<LPYBussinessCardAdapterProtocol>)bussinessCardData {
    _bussinessCardData = bussinessCardData;
    
    self.nameLabel.text = [_bussinessCardData name];
    self.lineView.backgroundColor = [_bussinessCardData lineColor];
    self.phoneNumberLabel.text = [_bussinessCardData phoneNumber];

}

@end
