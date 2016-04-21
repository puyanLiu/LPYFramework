//
//  UnitTestDemoUITests.m
//  UnitTestDemoUITests
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UnitTestDemoUITests : XCTestCase

@end

@implementation UnitTestDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample1111 {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *element = [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *textField = [[element childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"abc"];
    
    XCUIElement *textField2 = [[element childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1];
    [textField2 tap];
    
    XCUIElement *moreNumbersKey = app.keys[@"more, numbers"];
    [moreNumbersKey tap];
    [textField2 typeText:@"123"];
    [app.buttons[@"Return"] tap];
    [textField2 typeText:@"\n"];
    
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
    
    [self testLogin];
}

#pragma mark - 登录验证
/**
 *  XCUIApplication 继承XCUIElement，掌握应用程序的生命周期
 *  主要方法
 *  launch() 启动程序
 *  terminate() 终止程序
 *
 *  XCUIElement : NSObject <XCUIElementAttributes, XCUIElementTypeQueryProvider>
 *  表示系统的各种UI元素
 *  exists 判断当前的UI元素是否存在，如果对一个不存在的元素进行操作，会导致测试组件抛出异常并中断测试
 *  descendantsMatchingType: 获取某种类型的元素以及它的子类集合
 *  childrenMatchingType: 获取某种类型的元素集合，不包含它的子类
 *  以上两个方法的区别：如果仅使用系统的UIButton时，用childrenMatchingType，如果希望查询自定义的子Button，用descendantsMatchingType
 *  typeText: 用于文本框输入文本时使用，使用前要确保文本框获得输入焦点，可以使用tap()函数使其获得焦点
 *  XCUIElementAttributes协议 可以方便查看当前元素的特征
 *  XCUIElementTypeQueryProvider协议 可通过读属性的方式取得某种类型的UI集合
 */
- (void)testLogin {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    // UTF8编码
    XCUIElement *button = app.buttons[@"\u767b\u5f55"];
    [button tap];
    
    XCUIElement *button2 = app.alerts[@"\u6e29\u99a8\u63d0\u793a"].collectionViews.buttons[@"\u77e5\u9053\u4e86"];
    [button2 tap];
    
    XCUIElementQuery *elementsQuery = [app.otherElements containingType:XCUIElementTypeStaticText identifier:@"\u7528\u6237\u540d"];
    XCUIElement *textField = [[elementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    [textField tap];
    
    XCUIApplication *app2 = app;
    XCUIElement *moreNumbersKey = app2.keys[@"more, numbers"];
    [moreNumbersKey tap];
    XCUIElement *moreLettersKey = app2.keys[@"more, letters"];
    [moreLettersKey tap];
    [textField typeText:@"admin"];
    [button tap];
    [button2 tap];
    
    XCUIElement *textField2 = [[elementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1];
    [textField2 tap];
    [moreNumbersKey tap];
    [textField2 typeText:@"666666"];
    [button tap];
    [button2 tap];
}

@end
