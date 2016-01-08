//
//  LPYQRCodeScanningViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYQRCodeScanningViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LPYCommonHelp.h"

@interface LPYQRCodeScanningViewController () <AVCaptureMetadataOutputObjectsDelegate, UITabBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
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

// topView
@property (nonatomic, strong) IBOutlet UIView *topView;
// leftView
@property (nonatomic, strong) IBOutlet UIView *leftView;
// rightView
@property (nonatomic, strong) IBOutlet UIView *rightView;
// bottomView
@property (nonatomic, strong) IBOutlet UIView *bottomView;

// 会话
@property (nonatomic, strong) AVCaptureSession *session;
// 预览图层
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *layer;
// 输出设备
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
// 输出设备
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
// 用于判断照片中是否有二维码
@property (nonatomic, strong) CIDetector *detector;
@end

@implementation LPYQRCodeScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNav];
    [self setupUI];
    [self setupScan];
    [self setupOverlayView];
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

- (void)setupNav {
    self.title = @"二维码/条形码扫描";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择相册" style:UIBarButtonItemStylePlain target:self action:@selector(btn_AlumbClick)];
}

- (void)setupUI {
    self.customeTabBar.selectedItem = [self.customeTabBar.items firstObject];
    self.customeTabBar.delegate = self;
    self.QRCodeView.clipsToBounds = YES;
}

// 设置遮盖图层
- (void)setupOverlayView {
    CGFloat alpha = 0.6;
    UIColor *bgColor = [UIColor blackColor];
    self.topView.backgroundColor = bgColor;
    self.topView.alpha = alpha;
    self.bottomView.backgroundColor = bgColor;
    self.bottomView.alpha = alpha;
    self.leftView.backgroundColor = bgColor;
    self.leftView.alpha = alpha;
    self.rightView.backgroundColor = bgColor;
    self.rightView.alpha = alpha;
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
    
    // 3.1.设置输入元数据的类型(类型是二维码数据/条形码数据),要在输出数据之后添加
    NSMutableArray *types = [NSMutableArray array];
    if ([self.output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        [types addObject:AVMetadataObjectTypeQRCode];
    }
    if ([self.output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
        [types addObject:AVMetadataObjectTypeEAN13Code];
    }
    if ([self.output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
        [types addObject:AVMetadataObjectTypeEAN8Code];
    }
    if ([self.output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
        [types addObject:AVMetadataObjectTypeCode128Code];
    }
    [self.output setMetadataObjectTypes:types];
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
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择相册" style:UIBarButtonItemStylePlain target:self action:@selector(btn_AlumbClick)];
    } else if (item.tag == 2) {
        self.QRCodeHeightConstraint.constant = 150;
        self.lbl_Info.text = @"将条码放入框内，即可自动扫描";
        self.btn_MeQRCode.hidden = YES;
        self.animateImageView.image = [UIImage imageNamed:@"qrcode_scanline_barcode"];
        self.navigationItem.rightBarButtonItem = nil;
    }
    [self stopAnimation];
    [self startAnimation];
}

#pragma mark - 相册处理
- (void)btn_AlumbClick {
    // 判断相册是否获得权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusAuthorized || author == ALAuthorizationStatusNotDetermined) {
        // 判断照片源是否可用
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            return;
        }
        // 创建照片选择控制器
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        // 设置代理
        imagePicker.delegate = self;
        // 设置照片源
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"获取失败" message:@"请在iPhone的”设置-隐私-照片“选项中，允许缺钱么访问你的照片" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [LPYCommonHelp openAPPSetting];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


// 处理用户选择的照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 获取用户选择的图片并显示到imageView上
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    // 关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSArray *features = [self.detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count >= 1) {
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scannedResult = feature.messageString;
        [self playSound];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"已识别此二维码内容为：\n%@", scannedResult] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"复制内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"照片中未识别到二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
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
        // 高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    return _session;
}
- (AVCaptureVideoPreviewLayer *)layer
{
    if(!_layer)
    {
        _layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer insertSublayer:_layer atIndex:0];
    }
    return _layer;
}
- (CIDetector *)detector
{
    if(!_detector)
    {
        _detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    }
    return _detector;
}
@end
