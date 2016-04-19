//
//  UnitTestDemoTests.m
//  UnitTestDemoTests
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AFNetworking.h>
#import <STAlertView/STAlertView.h>

// waitForExpectationsWithTimeout是等待时间，超过了就不再等待往下执行
#define WAIT do { \
    [self expectationForNotification:@"LPYBaseTest" object:nil handler:nil]; \
    [self waitForExpectationsWithTimeout:30 handler:nil]; \
} while (0);

#define NOTIFY [[NSNotificationCenter defaultCenter] postNotificationName:@"LPYBaseTest" object:nil];

@interface UnitTestDemoTests : XCTestCase
/**
 *  alertView
 */
@property (nonatomic, strong) STAlertView *stAlertView;
@end

@implementation UnitTestDemoTests

/**
 *  每个测试方法调用前执行
 */
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

/**
 *  每个测试方法调用后执行
 */
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 *  测试方法（可以新建），测试方法必须testXXX格式，且不能有参数，不然不会识别为测试方法。测试方法的执行顺序是字典序排序
 Command+U 全部测试
 */
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"自定义测试testExample");
    int a = 3;
    //    XCTAssertTrue(a == 0, "a不能等于0");
    XCTAssertFalse(a == 0, "a不能等于0");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - 网络请求的测试
/**
 *  由于测试方法主线程执行完就会结束，所以需要设置一下，否则没法查看异步返回结果。在方法结束前设置等待，调用回来的时候再让它继续执行
 */
- (void)testRequest {
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    // 2.发送GET请求
    [mgr GET:@"http://www.weather.com.cn/adat/sk/101110101.html" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"responseObject: %@", responseObject);
        XCTAssertNotNil(responseObject, @"返回出错");
        // 继续执行
        self.stAlertView = [[STAlertView alloc] initWithTitle:@"验证码" message:nil textFieldHint:@"请输入手机验证码" textFieldValue:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" cancelButtonBlock:^{
            // 点击取消返回后执行
            [self testAlertViewCancel];
            // 继续执行
            NOTIFY;
        } otherButtonBlock:^(NSString *otherBtn) {
            // 点击确定后执行
            [self testAlertViewConfirm];
            // 继续执行
            NOTIFY;
        }];
        [self.stAlertView show];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        XCTAssertNil(error, @"请求出错");
        // 继续执行
        NOTIFY
    }];
    // 暂停
    WAIT
}

- (void)testAlertViewCancel {
    NSLog(@"取消");
}

- (void)testAlertViewConfirm {
    [self alertViewConfirm:nil];
}

- (void)alertViewConfirm:(NSString *)test {
    NSLog(@"手机验证码：%@", test);
}

@end
