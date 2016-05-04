//
//  QQMPlaceHolderView.m
//  QQMProject
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "QQMPlaceHolderView.h"

@interface QQMPlaceHolderView ()
/**
 *  显示图片
 */
@property (nonatomic, strong) UIImageView *emptyOverlayImageView;

/**
 *  显示详情
 */
@property (nonatomic, strong) BaseLabel *emptyOverlayLabel;

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

- (instancetype)initWithFrame:(CGRect)frame noDataType:(NoDataType)noDataType {
    self = [super initWithFrame:frame];
    if (self) {
        switch (noDataType) {
            case NoDataTypeMessage:
                self.typeImage = [UIImage imageNamed:@"nomessage90"];
                self.typeTitle = @"暂无消息~~";
                break;
            case NoDataTypeBorrow:
                self.typeImage = [UIImage imageNamed:@"noBorrowData"];
                self.typeTitle = @"此项没有历史记录哦~~";
                break;
            case NoDataTypeAddress:
                self.typeImage = [UIImage imageNamed:@"noAddress"];
                self.typeTitle = @"没有收货地址哦~~";
                break;
            case NoDataTypeRedPacket:
                self.typeImage = [UIImage imageNamed:@"nohongbao90"];
                self.typeTitle = @"目前没有可用红包~~";
                break;
            case NoDataTypePastDueRed:
                self.typeImage = [UIImage imageNamed:@"nohongbao90"];
                self.typeTitle = @"没有红包记录~~";
                break;
            case NoDataTypeScores:
                self.typeImage = [UIImage imageNamed:@"nojifen90"];
                self.typeTitle = @"还没有历史痕迹哦~";
                break;
            case NoDataTypeMyprize:
                self.typeImage = [UIImage imageNamed:@"noprize"];
                self.typeTitle = @"还没有奖品记录哦~";
                break;
            case NoDataTypeInstallmentPayment:
                self.typeImage = [UIImage imageNamed:@"noInstallmentPayment"];
                self.typeTitle = @"暂无账单~~";
                break;
            default:
                break;
        }
        
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
    self.backgroundColor = QQMGlobalBackgroundColor;
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
    self.emptyOverlayImageView.y_ = (self.height_ - self.emptyOverlayImageView.height_ - self.emptyOverlayLabel.height_ - marginH - QQMStatusH - QQMNavH) * 0.5;
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

- (BaseLabel *)emptyOverlayLabel
{
    if(!_emptyOverlayLabel)
    {
        _emptyOverlayLabel = [[BaseLabel alloc] init];
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
