//
//  LPYWebViewController.h
//  LPYFramework
//
//  Created by admin on 16/6/17.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

/*
 // 初始化
 // 默认初始化
 - (instancetype)initWithFrame:(CGRect)frame;
 
 // 根据对webview的相关配置，进行初始化
 - (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration NS_DESIGNATED_INITIALIZER
 
 
 
 // 加载网页与HTML
 WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
 [self.view addSubview:webView];
 
 

 
 // 代理WKNavigationDelegate：该代理提供的方法，可以用来追踪加载过程（页面开始加载、加载完成、加载失败）、决定是否执行跳转。
 
 // 页面开始加载时调用
 - (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
 // 当内容开始返回时调用
 - (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
 // 页面加载完成之后调用
 - (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
 // 页面加载失败时调用
 - (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;
 
 页面跳转的代理方法有三种，分为（收到跳转与决定是否跳转两种）
 // 接收到服务器跳转请求之后调用
 - (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;
 // 在收到响应后，决定是否跳转
 - (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
 // 在发送请求之前，决定是否跳转
 - (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
 
 
 
 
 
 // WKUIDelegate
 // 创建一个新的WebView
 - (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;
 // 剩下三个代理方法全都是与界面弹出提示框相关的，针对于web界面的三种提示框（警告框、确认框、输入框）分别对应三种代理方法。下面只举了警告框的例子。

 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 *
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler;
 
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LPYWebViewController : UIViewController

@end
