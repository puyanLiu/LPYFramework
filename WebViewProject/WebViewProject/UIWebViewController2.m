//
//  UIWebViewController2.m
//  WebViewProject
//
//  Created by liupuyan on 17/2/14.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

#import "UIWebViewController2.h"
#import <JavaScriptCore/JavaScriptCore.h>

/*
 
 
 // OC调用JS
 // 方式一
 // 注意：该方法会同步返回一个字符串，因此是一个同步方法，可能会阻塞UI
 //        NSString *jsStr = [NSString stringWithFormat:@"showAlert('%@')",@"这里是JS中alert弹出的message"];
 //        [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
 
 // 方法二
 // 继续使用JavaScriptCore库来做JS交互
 NSString *textJS = @"showAlert('这里是JS中alert弹出的message')";
 [context evaluateScript:textJS];
 
 
 */
@interface UIWebViewController2 ()
<UIWebViewDelegate>
/**
 *  webView
 */
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation UIWebViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    self.title = @"UIWebView展示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 加载H5页面
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test3" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate
// JS调用OC
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    context[@"share"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        NSLog(@"-----------------------------------------%@", args);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"方式二" message:@"这是OC原生的弹出窗" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alert animated:YES completion:NULL];
        });
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
        }
        
        NSLog(@"-------End Log-------");
    };
    
}

- (UIWebView *)webView {
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        _webView.delegate = self;
    }
    return _webView;
}

@end
