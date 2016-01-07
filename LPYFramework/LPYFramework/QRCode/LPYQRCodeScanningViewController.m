//
//  LPYQRCodeScanningViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYQRCodeScanningViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LPYQRCodeScanningViewController () <AVCaptureMetadataOutputObjectsDelegate, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *customeTabBar;
// 显示信息
@property (weak, nonatomic) IBOutlet UILabel *lbl_Info;
@property (weak, nonatomic) IBOutlet UIView *QRCodeView;
// 我的二维码
@property (weak, nonatomic) IBOutlet UIButton *btn_MeQRCode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *QRCodeHeightConstraint;
// 冲击波
@property (weak, nonatomic) IBOutlet UIImageView *animateImageView;
// 冲击波距离顶部视图约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animateTopConstraint;


@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *layer;
/**
 *  deviceInput
 */
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
/**
 *  output
 */
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@end

@implementation LPYQRCodeScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    [self setupScan];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startAnimation];
    [self startScan];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopAnimation];
    [self stopScan];
}

- (void)setupUI {
    self.customeTabBar.selectedItem = [self.customeTabBar.items firstObject];
    self.customeTabBar.delegate = self;
    self.QRCodeView.clipsToBounds = YES;
}

// 开始冲击波动画
- (void)startAnimation {
    // 让约束从顶部开始
    self.animateTopConstraint.constant = - self.QRCodeHeightConstraint.constant;
    [self.animateImageView layoutIfNeeded];
    // 执行动画
    [UIView animateWithDuration:2.0 animations:^{
        self.animateTopConstraint.constant = self.QRCodeHeightConstraint.constant;
        // 动画执行次数
        [UIView setAnimationRepeatCount:MAXFLOAT];
        [self.animateImageView layoutIfNeeded];
    }];
}

- (void)stopAnimation {
    [self.animateImageView.layer removeAllAnimations];
}

// 开始扫描
- (void)setupScan {
    // 判断是否能够将输入添加到会话中
    if (![self.session canAddInput:self.deviceInput]) {
        return;
    }
    // 判断是否能讲输出添加到会话中
    if (![self.session canAddOutput:self.output]) {
        return;
    }
    
    // 2.添加输入设备(数据从摄像头输入)
    [self.session addInput:self.deviceInput];
    
    // 3.添加输出数据
    [self.session addOutput:self.output];
    
    // 3.1.设置输入元数据的类型(类型是二维码数据),要在输出数据之后添加
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]];
    
    // 5.开始扫描
    [self.session startRunning];
}

- (void)startScan {
    [self.session startRunning];
}

- (void)stopScan {
    [self.session stopRunning];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.layer.frame = self.view.bounds;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 1) {
        self.QRCodeHeightConstraint.constant = 300;
        self.lbl_Info.text = @"将二维码放入扫描框内，即可自动扫描";
        self.btn_MeQRCode.hidden = NO;
        self.animateImageView.image = [UIImage imageNamed:@"qrcode_scanline_qrcode"];
    } else if (item.tag == 2) {
        self.QRCodeHeightConstraint.constant = 150;
        self.lbl_Info.text = @"将条码放入框内，即可自动扫描";
        self.btn_MeQRCode.hidden = YES;
        self.animateImageView.image = [UIImage imageNamed:@"qrcode_scanline_barcode"];
    }
    [self stopAnimation];
    [self startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实现output的回调方法
// 当扫描到数据时就会执行该方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"%@", object.stringValue);
        
        // 停止扫描
        [self stopScan];
        
        // 播放声音
        [self playSound];
        
        // 将预览图层移除
        [self.layer removeFromSuperlayer];
    } else {
        NSLog(@"没有扫描到数据");
    }
}

// 播放扫描二维码的声音
- (void)playSound {
    SystemSoundID soundID;
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"noticeMusic" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)[NSURL fileURLWithPath:strPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark -懒加载
- (AVCaptureDeviceInput *)deviceInput
{
    if(!_deviceInput)
    {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    }
    return _deviceInput;
}
- (AVCaptureMetadataOutput *)output
{
    if(!_output)
    {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _output;
}
- (AVCaptureSession *)session
{
    if(!_session)
    {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}
- (AVCaptureVideoPreviewLayer *)layer
{
    if(!_layer)
    {
        _layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        [self.view.layer insertSublayer:_layer atIndex:0];
    }
    return _layer;
}
@end
