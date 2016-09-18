//
//  QQMNetReloader.m
//  QQMProject
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "QQMNetReloader.h"
#import "UIView+Extension.h"

#define NO_WINF_WORDS @"网络不太顺畅哦~"

@interface QQMNetReloader ()

/**
 *  nowifiImageView
 */
@property (nonatomic, strong) UIImageView *noWifiImageView;
/**
 *  noWifiLabel
 */
@property (nonatomic, strong) UILabel *noWifLabel;
/**
 *  reloadButton
 */
@property (nonatomic, strong) UIButton *reloadButton;
/**
 *  reloadBlock
 */
@property (nonatomic, copy) ReloadButtonClickBlock reloadButtonClickBlock;

@end

@implementation QQMNetReloader

- (instancetype)initWithFrame:(CGRect)frame
                  reloadBlock:(ReloadButtonClickBlock)reloadBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.reloadButtonClickBlock = reloadBlock;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.noWifiImageView];
    [self addSubview:self.noWifLabel];
    [self addSubview:self.reloadButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marginH = 10;
    
    self.noWifiImageView.y_ = (self.height_ - self.reloadButton.height_ - self.noWifiImageView.height_ - self.noWifLabel.height_ - marginH - 20 - 44) * 0.5;
    self.noWifLabel.y_ = CGRectGetMaxY(self.noWifiImageView.frame);
    self.reloadButton.y_ = CGRectGetMaxY(self.noWifLabel.frame) + marginH;
}

- (void)showInView:(UIView *)viewWillShow {
    [viewWillShow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (UIImageView *)noWifiImageView
{
    if(!_noWifiImageView)
    {
        _noWifiImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nowifi90"]];
        _noWifiImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.noWifiImageView.width_ = 90;
        self.noWifiImageView.height_ = self.noWifiImageView.width_;
        self.noWifiImageView.x_ = (self.width_ - self.noWifiImageView.width_) * 0.5;
    }
    return _noWifiImageView;
}

- (UILabel *)noWifLabel
{
    if(!_noWifLabel)
    {
        _noWifLabel = [[UILabel alloc] init];
        _noWifLabel.text = NO_WINF_WORDS;
        [_noWifLabel sizeToFit];
        _noWifLabel.numberOfLines = 0;
        
        CGFloat margin = 30;
        self.noWifLabel.x_ = margin;
        self.noWifLabel.width_ = self.width_ - margin * 2;
        self.noWifLabel.height_ = 40;
        self.noWifLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noWifLabel;
}

- (UIButton *)reloadButton
{
    if(!_reloadButton)
    {
        _reloadButton = [[UIButton alloc] init];
        _reloadButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.reloadButton.width_ = 120;
        self.reloadButton.height_ = 40;
        self.reloadButton.x_ = (self.width_ - self.reloadButton.width_) * 0.5;
    }
    return _reloadButton;
}

- (void)reloadButtonClicked {
    if (self.reloadButtonClickBlock) {
        self.reloadButtonClickBlock();
    }
}
@end
