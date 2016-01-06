//
//  LPYQRCodeViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYQRCodeViewController.h"
#import "UIView+Extension.h"
#import "UIImage+Extension.h"

@interface LPYQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;

@end

@implementation LPYQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分享二维码";
    [self setupUI];
    [self qrCodeGenerator];
}

- (void)setupUI
{
    self.QRImageView.layer.cornerRadius = 5.0;
}

- (void)qrCodeGenerator
{
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = @"https://appsto.re/cn/KLUE9.i";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 设置二维码的纠错级别
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5.显示二维码
    self.QRImageView.image = [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:self.QRImageView.size_.width];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
