//
//  UIWebViewController.m
//  WebViewProject
//
//  Created by liupuyan on 17/2/14.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

#import "UIWebViewController.h"

@interface UIWebViewController () <UIWebViewDelegate>
/**
 *  webView
 */
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    self.title = @"UIWebView展示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 加载H5页面
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test2" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate
// JS调用OC
/*
 第一种方式是用JS发起一个假的URL请求，然后利用UIWebView的代理方法拦截这次请求，然后再做相应的处理
 
 注意：
 1. JS中的firstClick,在拦截到的url scheme全都被转化为小写。
 2.html中需要设置编码，否则中文参数可能会出现编码问题。
 3.JS用打开一个iFrame的方式替代直接用document.location的方式，以避免多次请求，被替换覆盖的问题
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"firstclick"]) {
        NSArray *params =[url.query componentsSeparatedByString:@"&"];
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (NSString *paramStr in params) {
            NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
            if (dicArray.count > 1) {
                NSString *decodeValue = [dicArray[1] stringByRemovingPercentEncoding];
                [tempDic setObject:decodeValue forKey:dicArray[0]];
            }
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"方式一" message:@"这是OC原生的弹出窗" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:NULL];
        NSLog(@"tempDic:%@",tempDic);
        return NO;
    }
    
    return YES;
}

- (UIWebView *)webView {
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        _webView.delegate = self;
    }
    return _webView;
}
@end
