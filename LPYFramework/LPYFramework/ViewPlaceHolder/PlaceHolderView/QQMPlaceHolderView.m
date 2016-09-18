//
//  QQMPlaceHolderView.m
//  QQMProject
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "QQMPlaceHolderView.h"
#import "UIView+Extension.h"

@interface QQMPlaceHolderView ()
/**
 *  显示图片
 */
@property (nonatomic, strong) UIImageView *emptyOverlayImageView;

/**
 *  显示详情
 */
@property (nonatomic, strong) UILabel *emptyOverlayLabel;

/**
 *  标题
 */
@property (nonatomic, strong) NSString *typeTitle;
/**
 *  图片
 */
@property (nonatomic, strong) UIImage *typeImage;
@end

@implementation QQMPlaceHolderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.typeImage = [UIImage imageNamed:@"nomessage90"];
        self.typeTitle = @"暂无消息~~";
        
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)sharedInit {
    self.backgroundColor = [UIColor whiteColor];
    self.contentMode = UIViewContentModeCenter;
    [self addSubview:self.emptyOverlayImageView];
    [self addSubview:self.emptyOverlayLabel];
    [self setupEmptyOverlay];
    return self;
}

- (void)setupEmptyOverlay {
    UILongPressGestureRecognizer *longPressEmptyOverlay = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressEmptyOverlay:)];
    [longPressEmptyOverlay setMinimumPressDuration:0.001];
    [self addGestureRecognizer:longPressEmptyOverlay];
    self.userInteractionEnabled = YES;
}

- (void)longPressEmptyOverlay:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.emptyOverlayImageView.alpha = 0.4;
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.emptyOverlayImageView.alpha = 1;
        if ([self.delegate respondsToSelector:@selector(emptyOverlayClicked:)]) {
            [self.delegate emptyOverlayClicked:nil];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marginH = 10;
    self.emptyOverlayImageView.y_ = (self.height_ - self.emptyOverlayImageView.height_ - self.emptyOverlayLabel.height_ - marginH - 20 - 44) * 0.5;
    self.emptyOverlayLabel.y_ = CGRectGetMaxY(self.emptyOverlayImageView.frame);
}

- (UIImageView *)emptyOverlayImageView
{
    if(!_emptyOverlayImageView)
    {
        _emptyOverlayImageView = [[UIImageView alloc] init];
        _emptyOverlayImageView.image = self.typeImage ?: [UIImage imageNamed:@"refreshIcon"];
        _emptyOverlayImageView.width_ = 90;
        _emptyOverlayImageView.height_ = _emptyOverlayImageView.width_;
        _emptyOverlayImageView.x_ = (self.width_ - _emptyOverlayImageView.width_) * 0.5;
    }
    return _emptyOverlayImageView;
}

- (UILabel *)emptyOverlayLabel
{
    if(!_emptyOverlayLabel)
    {
        _emptyOverlayLabel = [[UILabel alloc] init];
        _emptyOverlayLabel.numberOfLines = 0;
        _emptyOverlayLabel.backgroundColor = [UIColor clearColor];
        _emptyOverlayLabel.text = [NSString stringWithFormat:@"%@%@", self.typeTitle, @"\n\n轻触屏幕重新加载"];
        CGFloat margin = 30;
        _emptyOverlayLabel.x_ = margin;
        _emptyOverlayLabel.width_ = self.width_ - margin * 2;
        _emptyOverlayLabel.height_ = 60;
        _emptyOverlayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _emptyOverlayLabel;
}
@end
