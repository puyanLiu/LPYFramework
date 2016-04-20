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
#import "ViewController.h"

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
/**
 *  vc
 */
@property (nonatomic, strong) ViewController *vc;
@end

@implementation UnitTestDemoTests

/**
 *  每个测试方法调用前执行
 */
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[ViewController alloc] init];
}

/**
 *  每个测试方法调用后执行
 */
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
    
    [super tearDown];
}

- (void)testMyFunc {
    // 调用需要测试的方法
    int result = [self.vc getNum];
    // 如果不相等则会提示“测试不通过”
    XCTAssertEqual(result, 100, @"测试不通过");
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

/**
 *  测试某个方法的性能
 */
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    // 测试性能例子
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 需要测试性能的代码
        for (int i = 0; i < 1000; i++) {
            NSLog(@"测试-%d", i);
        }
    }];
}

#pragma mark - 测试各个断言的用户
- (void)testAssert {
//    XCTFail(format...) 生成一个失败的测试
//    XCTFail(@"Fail");
    
//    XCTAssertNil(a1, format...) 为空判断，a1为空时通过，反之不通过
//    XCTAssertNil(@"not nil string", @"string must be nil");
    
//    XCTAssertNotNil(a1, format...) 不为空判断，a1不为空时通过，反之不通过
//    XCTAssertNotNil(@"not nil string", @"string can not be nil");
    
//    XCTAssert(expression, format...) 当expression求值为true时通过
//    XCTAssert((2 > 2), @"expression must be true");
    
//    XCTAssertTrue(expression, format...) 当expression求值为true时通过
//    XCTAssertTrue(1, @"Can not be zero");
    
//    XCTAssertFalse(expression, format...) 当expression求值为false时通过
//    XCTAssertFalse((2 < 2), @"expression must be false");
    
//    XCTAssertEqualObjects(a1, a2, format...) 判断相等，[a1 isEqual:a2]值为true时通过
//    XCTAssertEqualObjects(@"1", @"1", @"[a1 isEqual a2] should return YES");
//    XCTAssertEqualObjects(@"1", @"2", @"[a1 isEqual a2] should return YES");
//    XCTAssertEqualObjects(nil, nil, @"[a1 isEqual a2] should return YES");
    
//    XCTAssertNotEqualObjects(a1, a2, format...) 判断不等，[a1 isEqual:a2]值为false时通过
//    XCTAssertNotEqualObjects(@"1", @"2", @"[a1 isEqual a2] should return NOT");
    
//    XCTAssertNotEqual(a1, a2, format...) 判断相等
//    1、比较基本数据类型变量
//    XCTAssertEqual(1, 2, @"a1 = a2 should be true"); // 无法通过测试
//    XCTAssertEqual(1, 1, @"a1 = a2 should be true");
//    2、比较NSString对象
//    NSString *str1 = @"1";
//    NSString *str2 = @"1";
//    NSString *str3 = str1;
//    XCTAssertEqual(str1, str2, @"a1 and a2 should point to the same object"); //通过测试
//    XCTAssertEqual(str1, str3, @"a1 and a2 should point to the same object"); //通过测试
//    3、比较NSArray对象
//    NSArray *array1 = @[@1];
//    NSArray *array2 = @[@1];
//    NSArray *array3 = array1;
//    XCTAssertEqual(array1, array2, @"a1 and a2 should point to the same object"); //无法通过测试
//    XCTAssertEqual(array1, array3, @"a1 and a2 should point to the same object"); //通过测试

//    XCTAssertNotEqual(a1, a2, format...) 判断不等
    
//    XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...) 判断相等，(double 或 float类型)提供一个误差范围（+/- accuracy）以内相等时通过测试
//    XCTAssertEqualWithAccuracy(1.0f, 1.5f, 0.25f, @"a1 = a2 in accuracy should return YES");
    
//    XCTAssertNotEqualWithAccuracy(a1, a2, accuracy, format...) 判断不等，(double 或 float类型)提供一个误差范围（+/- accuracy）以内不等时通过测试
//    XCTAssertNotEqualWithAccuracy(1.0f, 1.5f, 0.25f, @"a1 = a2 in accuracy should return NO");
    
//    XCTAssertNoThrow(expression, format...) 异常测试，当expression发生异常时通过，反之不通过
    
//    XCTAssertNoThrowSpecific(expression, sepcificException, format...) 异常测试，当expression发生sepcificException异常时通过，反之发生其他异常或者不发生异常均不通过
    
//    XCTAssertNoThrowSpecificNamed(expression, sepcificException, exception_name, format...) 异常测试，当expresstion发生具体异常、具体异常名称时通过测试，反之不通过
    
//    XCTAssertNoThrow(expression, format...) 异常测试，当expression没有发生异常时通过测试
    
//    XCTAssertNoThrowSpecific(expression, sepcificException, format...) 异常测试，当expression没有发生sepcificException异常时通过，反之不通过
    
//    XCTAssertNoThrowSpecificNamed(expression, sepcificException, exception_name, format...) 异常测试，当expresstion没有发生具体异常、具体异常名称时通过测试，反之不通过
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
        NOTIFY
//        self.stAlertView = [[STAlertView alloc] initWithTitle:@"验证码" message:nil textFieldHint:@"请输入手机验证码" textFieldValue:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" cancelButtonBlock:^{
//            // 点击取消返回后执行
//            [self testAlertViewCancel];
//            // 继续执行
//            NOTIFY;
//        } otherButtonBlock:^(NSString *otherBtn) {
//            // 点击确定后执行
//            [self testAlertViewConfirm];
//            // 继续执行
//            NOTIFY;
//        }];
//        [self.stAlertView show];
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
