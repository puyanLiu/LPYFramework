//
//  LPYADView.m
//  LPYFramework
//
//  Created by liupuyan on 16/9/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYADView.h"

@interface LPYADView ()
/**
 *  describle
 */
@property (nonatomic, strong) UIImageView *adImageView;
/**
 *  describle
 */
@property (nonatomic, strong) UIButton *countBtn;
/**
 *  describle
 */
@property (nonatomic, strong) NSTimer *countTimer;
/**
 *  <#describle#>
 */
@property (nonatomic, assign) NSUInteger count;
/**
 *  广告图片本地路径
 */
@property (nonatomic, copy) NSString *filePath;
/**
 *  新广告图片地址
 */
@property (nonatomic, copy) NSString *imgUrl;
/**
 *  新广告的链接
 */
@property (nonatomic, copy) NSString *adUrl;
/**
 *  所点击的广告链接
 */
@property (nonatomic, copy) NSString *clickAdUrl;
/**
 *  点击回调block
 */
@property (nonatomic, copy) void(^clickBlock)(NSString *url);
@end

@implementation LPYADView

- (NSUInteger)showTime {
    if (_showTime == 0) {
        return 3;
    }
    return _showTime;
}

/**
 *  初始化方法
 *
 *  @param frame    <#frame description#>
 *  @param imageUrl <#imageUrl description#>
 *  @param adUrl    <#adUrl description#>
 *  @param block    <#block description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame imgUrl:(NSString *)imageUrl adUrl:(NSString *)adUrl clickImgBlock:(void(^)(NSString *clickImgUrl))block {
    self = [super initWithFrame:frame];
    if (self) {
        // 赋值
        _clickBlock = block;
        _imgUrl = imageUrl;
        _adUrl = adUrl;
        
        // 广告图片
        _adImageView = [[UIImageView alloc] initWithFrame:frame];
        _adImageView.userInteractionEnabled = YES;
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(pushToAd)];
        [_adImageView addGestureRecognizer:tap];
        
        // 跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - btnW - 24, btnH, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:38 / 255.0 blue:38 / 255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = 4;
        
        [self addSubview:_adImageView];
        [self addSubview:_countBtn];
        
    }
    return self;
}

/**
 *  显示广告页面
 */
- (void)show {
    // 判断本地存储广告是否存在，存在即显示
    if ([self imageExist]) {
        // 设置按钮倒计时
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%zd", self.showTime] forState:UIControlStateNormal];
        // 当前显示的广告图片
        _adImageView.image = [UIImage imageWithContentsOfFile:_filePath];
        // 当前显示的广告链接
        _clickAdUrl = [UserDefaults valueForKey:adUrl];
        // 倒计时方法1：GCD
        [self startCountDown];
        // 倒计时方法2：倒计时
//        [self startTimer];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    }
    
    // 不管本地是否存在广告图片都获取最新图片
    [self setNewADImgUrl:_imgUrl];
}

/**
 *  判断沙盒中是否存在广告图片，如果存在，直接显示
 *
 *  @return <#return value description#>
 */
- (BOOL)imageExist {
    _filePath = [self getFilePathWithImageName:[UserDefaults valueForKey:adImageName]];
    BOOL isExist = [self isFileExistWithFilePath:_filePath];
    return isExist;
}

/**
 *  获取最新广告
 *
 *  @param imgUrl <#imgUrl description#>
 */
- (void)setNewADImgUrl:(NSString *)imgUrl {
    // 获取图片名称 (***.png)
    NSString *imgName = [[imgUrl componentsSeparatedByString:@"/"] lastObject];
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imgName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist) {
        // 如果本地没有该图片，下载新图片保存，并且删除旧图片
        [self downloadAdImageWithUrl:imgUrl imageName:imgName];
    }
}

/**
 *  下载新图片（可使用SDWebImage下载）
 *
 *  @param imageUrl  <#imageUrl description#>
 *  @param imageName <#imageName description#>
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName];
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
            // 保存成功
            NSLog(@"保存成功");
            // 删除旧广告图片
            [self deletedOldImage];
            // 设置新图片
            [UserDefaults setValue:imageName forKey:adImageName];
            // 设置广告链接
            [UserDefaults setValue:_adUrl forKey:adUrl];
            [UserDefaults synchronize];
        } else {
            // 保存失败
            NSLog(@"保存失败");
        }
    });
}

/**
 *  跳转到广告页面
 */
- (void)pushToAd {
    if (_clickAdUrl) {
        _clickBlock(_clickAdUrl);
        [self dismiss];
    }
}

/**
 *   移除广告页面
 */
- (void)dismiss {
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSTimer *)countTimer {
    if(!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

/**
 *  跳过按钮设置
 */
- (void)countDown {
    _count--;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%zd", _count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self dismiss];
    }
}

#pragma mark - 倒计时
/**
 *  GCD倒计时
 */
- (void)startCountDown {
    __block NSUInteger timeout = self.showTime + 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            // 倒计时结束 关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countBtn setTitle:[NSString stringWithFormat:@"跳过%zd", timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

/**
 *  定时器倒计时
 */
- (void)startTimer {
    _count = self.showTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - 文件操作
/**
 *  判断文件是否存在
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = false;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  根据图片名拼接文件路径
 *
 *  @param imageName <#imageName description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName {
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}

/**
 *  删除旧图片
 */
- (void)deletedOldImage {
    NSString *imageName = [UserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}
@end
