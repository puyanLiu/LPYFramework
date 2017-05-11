//
//  WkWebViewController.m
//  WebViewProject
//
//  Created by liupuyan on 17/2/10.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

//http://www.jianshu.com/p/7bb5f15f1daa

#import "WkWebViewController.h"
#import <WebKit/WebKit.h>

@interface WkWebViewController () <WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
/**
 *  webView
 */
@property (nonatomic, strong) WKWebView *webView;
/**
 *  底部状态栏
 */
@property (nonatomic, strong) UIToolbar *toolBar;

@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation WkWebViewController
/*
 系统在某些情况下会自动调节UIScrollView的contentInset
 
 出现场景
 如果一个控制器被导航控制器管理，并且该控制器的第一个子控件是UIScrollView，系统默认会调节UIScrollView的contentInset
 UIEdgeInsetsMake(64, 0, 0, 0) // 有导航栏
 UIEdgeInsetsMake(20, 0, 0, 0) // 没有导航栏
 
 如果上述的导航控制器又被UITabBarController管理
 UIEdgeInsetsMake(64, 0, 49, 0) // 导航控制器又被UITabBarController管理
 
 取消系统的默认这种自动调节功能
 ViewController.automaticallyAdjustsScrollViewInsets = NO;
 
 */
/*
 NSURL 各个属性
 NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/search?id=1"];
 NSLog(@"scheme:%@", [url scheme]); //协议 http
 NSLog(@"host:%@", [url host]);     //域名 www.baidu.com
 NSLog(@"absoluteString:%@", [url absoluteString]); //完整的url字符串 http://www.baidu.com:8080/search?id=1   (刚才在真机上跑了一下，并没有打印出来端口 8080 啊)
 NSLog(@"relativePath: %@", [url relativePath]); //相对路径 search
 NSLog(@"port :%@", [url port]);  // 端口 8080
 NSLog(@"path: %@", [url path]);  // 路径 search
 NSLog(@"pathComponents:%@", [url pathComponents]); // search
 NSLog(@"Query:%@", [url query]);  //参数 id=1
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.progressView];
    [self.view insertSubview:self.webView belowSubview:self.progressView];
    [self.view addSubview:self.toolBar];
    self.title = @"WKWebView展示";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 加载H5页面
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test1" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    // 移除监听
    [self.webView removeObserver:self forKeyPath:@"loading" context:nil];//移除kvo
    [self.webView removeObserver:self forKeyPath:@"title" context:nil];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addAllScriptHandle];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeAllScriptHandle];
}

/*
 JS端使用 window.webkit.messageHandlers.<name>.postMessage(<messageBody>)
 html调用发送数据给iOS端
 window.webkit.messageHandlers.AppModel.postMessage({body: '传数据'});
 AppModel就是我们要注入的名称，注入以后，就可以在JS端调用了，传数据统一通过body传，可以是多种类型，只支持NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull类型
 */
- (void)addAllScriptHandle {
    WKUserContentController *userContentController = self.webView.configuration.userContentController;
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，我们可以在WKScriptMessageHandler代理中接收到
    // 可以注入多个名称（JS对象），用于区分功能（JS调用原生方法，可以通过此方式）
    [userContentController addScriptMessageHandler:self name:@"AppModel"];
}

- (void)removeAllScriptHandle {
    // 移除注入的JS
    WKUserContentController *userContentController = self.webView.configuration.userContentController;
    [userContentController removeScriptMessageHandlerForName:@"AppModel"];
}

#pragma mark - WKScriptMessageHandler
// 所有JS调用iOS的部分，都可以在此处使用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // 这里可以通过name处理多组交互
    if ([message.name isEqualToString:@"AppModel"]) {
        // message: 所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull类型
        // 实时接收js传递的数据
        NSLog(@"js传过来的参数: %@", message.body);
    }
}

#pragma mark - WKUIDelegate 
#pragma mark 处理三种弹框
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"DidClose--------%s", __FUNCTION__);
}

/*
 alert弹框
 在JS端调用alert函数时，会触发此代理方法
 JS端调用alert时所传的数据可以通过message拿到
 在原生得到结果后，需要回调JS，是通过completionHandler回调
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert样式" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@ \n%d \n%@ \n%@", frame, frame.isMainFrame, frame.request.URL, frame.securityOrigin);
        completionHandler(); // 必须实现(点击的回调)
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

/*
 confirm弹框
 JS端调用confirm函数时，会触发此方法
 通过message可以拿到JS端所传的数据
 在iOS端显示原生alert得到YES/NO后
 通过completionHandler回调给JS端
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm样式" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@ \n%d \n%@ \n%@", frame, frame.isMainFrame, frame.request.URL, frame.securityOrigin);
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@ \n%d \n%@ \n%@", frame, frame.isMainFrame, frame.request.URL, frame.securityOrigin);
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

/*
 prompt弹框
 JS端调用prompt函数时，会触发此方法
 要求输入一段文本
 在原生输入得到文本内容后，通过completionHandler回调给JS
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput样式" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blueColor];
        textField.backgroundColor = [UIColor clearColor];
        textField.placeholder = defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"prompt------ %@ defaultText------ %@", prompt, defaultText);
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - 对WKWebView属性的监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        // 监听进度条
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else if (object == self.webView && [keyPath isEqualToString:@"loading"]) {
        // 例如在loading完成后，可以注入一些JS到Web中
        NSLog(@"loading-------%d", self.webView.loading);
    } else if(object == self.webView && [keyPath isEqualToString:@"title"]) {
        // 获取页面标题
        if(self.webView.title)
            self.title = self.webView.title;
    }
    
    // 加载完成
    if(!self.webView.loading) {
        // 手动调用JS代码
        // 每次页面完成都弹出来
        NSString *js = @"alertPop()";
        [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
            NSLog(@"call js alert by native");
        }];
        
        // 另一种方法结束进度条
//        [UIView animateWithDuration:0.5 animations:^{
//            self.progressView.alpha = 0;
//        }];
    }
}

#pragma mark - WKNavigationDelegate
#pragma mark 代理提供的方法，可以用来追踪加载过程（页面开始加载、加载完成、加载失败）、决定是否执行跳转
#pragma mark 开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载时调用");
}

#pragma mark 页面内容到达main frame时回调
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"当内容开始返回时调用");
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用");
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"页面加载失败时调用");
}

#pragma mark 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
     NSLog(@"导航失败时会回调");
}

#pragma mark 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS验证证书是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

#pragma mark 9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"9.0才能使用，web内容处理中断时会触发");
}

#pragma mark 页面跳转的代理相关方法
#pragma mark 接收到重定向时会回调
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"接收到服务器跳转请求之后调用");
}

#pragma mark 在发送请求之前，决定是否跳转，可以在此拦截URL
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    decisionHandler(WKNavigationActionPolicyCancel);
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"URL: %@, scheme: %@", navigationAction.request.URL, navigationAction.request.URL);
    NSLog(@"先调用");
    
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        && ![hostname containsString:@".baidu.com"]) {
        // 对于跨域，需要手动跳转
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:nil];
        
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark 在接收到响应后，会回调此方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    // 如果设置为不允许响应，web内容就不会传过来
    //    decisionHandler(WKNavigationResponsePolicyCancel);
    NSLog(@"后调用");
}

#pragma mark - 底部状态栏
- (void)btn_Back {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        NSLog(@"不能后退");
    }
}

- (void)btn_Forward {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    } else {
        NSLog(@"不能前进");
    }
}

- (void)btn_Reload {
    [self.webView reload];
}

- (void)btn_SafariOpen {
    [[UIApplication sharedApplication] openURL:self.webView.URL options:@{} completionHandler:nil];
}

#pragma mark - 懒加载
/*
 上文介绍过的偏好配置
 @property (nonatomic, readonly, copy) WKWebViewConfiguration *configuration;
 导航代理
 @property (nullable, nonatomic, weak) id <WKNavigationDelegate> navigationDelegate;
 用户交互代理
 @property (nullable, nonatomic, weak) id <WKUIDelegate> UIDelegate;
 页面前进、后退列表
 @property (nonatomic, readonly, strong) WKBackForwardList *backForwardList;
 默认构造器
 - (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
 加载请求API
 - (nullable WKNavigation *)loadRequest:(NSURLRequest *)request;
 加载URL
 - (nullable WKNavigation *)loadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL NS_AVAILABLE(10_11, 9_0);
 直接加载HTML
 - (nullable WKNavigation *)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
 直接加载data
 - (nullable WKNavigation *)loadData:(NSData *)data MIMEType:(NSString *)MIMEType characterEncodingName:(NSString *)characterEncodingName baseURL:(NSURL *)baseURL NS_AVAILABLE(10_11, 9_0);
 前进或者后退到某一页面
 - (nullable WKNavigation *)goToBackForwardListItem:(WKBackForwardListItem *)item;
 页面的标题，支持KVO的
 @property (nullable, nonatomic, readonly, copy) NSString *title;
 当前请求的URL，支持KVO的
 @property (nullable, nonatomic, readonly, copy) NSURL *URL;
 标识当前是否正在加载内容中，支持KVO的
 @property (nonatomic, readonly, getter=isLoading) BOOL loading;
 当前加载的进度，范围为[0, 1]
 @property (nonatomic, readonly) double estimatedProgress;
 标识页面中的所有资源是否通过安全加密连接来加载，支持KVO的
 @property (nonatomic, readonly) BOOL hasOnlySecureContent;
 当前导航的证书链，支持KVO
 @property (nonatomic, readonly, copy) NSArray *certificateChain NS_AVAILABLE(10_11, 9_0);
 是否可以招待goback操作，它是支持KVO的
 @property (nonatomic, readonly) BOOL canGoBack;
 是否可以执行gofarward操作，支持KVO
 @property (nonatomic, readonly) BOOL canGoForward;
 返回上一页面，如果不能返回，则什么也不干
 - (nullable WKNavigation *)goBack;
 进入下一页面，如果不能前进，则什么也不干
 - (nullable WKNavigation *)goForward;
 重新载入页面
 - (nullable WKNavigation *)reload;
 重新从原始URL载入
 - (nullable WKNavigation *)reloadFromOrigin;
 停止加载数据
 - (void)stopLoading;
 执行JS代码
 - (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ __nullable)(__nullable id, NSError * __nullable error))completionHandler;
 标识是否支持左、右swipe手势是否可以前进、后退
 @property (nonatomic) BOOL allowsBackForwardNavigationGestures;
 自定义user agent，如果没有则为nil
 @property (nullable, nonatomic, copy) NSString *customUserAgent NS_AVAILABLE(10_11, 9_0);
 在iOS上默认为NO，标识不允许链接预览
 @property (nonatomic) BOOL allowsLinkPreview NS_AVAILABLE(10_11, 9_0);
 
 #if TARGET_OS_IPHONE
    @property (nonatomic, readonly, strong) UIScrollView *scrollView;
 #endif

 #if !TARGET_OS_IPHONE
     标识是否支持放大手势，默认为NO
     @property (nonatomic) BOOL allowsMagnification;
     放大因子，默认为1
     @property (nonatomic) CGFloat magnification;
     根据设置的缩放因子来缩放页面，并居中显示结果在指定的点
     - (void)setMagnification:(CGFloat)magnification centeredAtPoint:(CGPoint)point;
 #endif
 */
- (WKWebView *)webView {
    if(!_webView) {
        // 创建配置类
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 配置偏好设置
        WKPreferences *preferences = [[WKPreferences alloc] init];
        // 默认为0
        preferences.minimumFontSize = 10;
        // 默认为YES
        preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        preferences.javaScriptCanOpenWindowsAutomatically = NO;
        config.preferences = preferences;
        
        // 配置web内容处理池
        // web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建
        WKProcessPool *processPool = [[WKProcessPool alloc] init];
        config.processPool = processPool;
        
        // 配置Js与Web内容交互
        // WKUserContentController是用于给JS注入对象的，注入对象后，JS端就可以使用
        // WKUserContentController是用于与JS交互的类，而所注入的JS是WKUserScript对象
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        config.userContentController = userContentController;
        
        // 创建WKWebView
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) configuration:config];
        // 与webView UI交互代理
        // 需要与在JS调用alert、confirm、prompt函数时，通过IOS原生来处理，而不是调用JS的alert、confirm、prompt函数，需要设置UIDelegate
        _webView.UIDelegate = self;
        // 导航代理
        // web导航条上的代理处理，比如链接是否可以跳转或者如何跳转
        _webView.navigationDelegate = self;
        
        // 添加对WKWebView属性的监听
        // 是否正在加载
        [_webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
        // 获取页面标题
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        // 当前页面载入进度
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (UIToolbar *)toolBar {
    if(!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(btn_Back)];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStylePlain target:self action:@selector(btn_Forward)];
        UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(btn_Reload)];
        UIBarButtonItem *item6 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *item7 = [[UIBarButtonItem alloc] initWithTitle:@"Safari打开" style:UIBarButtonItemStylePlain target:self action:@selector(btn_SafariOpen)];
        _toolBar.items = @[item1, item2, item3, item4, item5, item6, item7];
    }
    return _toolBar;
}

- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0)];
        self.progressView.tintColor = [UIColor orangeColor];
        self.progressView.trackTintColor = [UIColor grayColor];
    }
    return _progressView;
}
@end
