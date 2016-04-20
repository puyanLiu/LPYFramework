//
//  EmptyAppTests.m
//  UnitTestDemo
//
//  Created by admin on 16/4/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestObject.h"

@interface EmptyAppTests : XCTestCase {
    TestObject *obj;
}

@end

@implementation EmptyAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    obj = [[TestObject alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)test_addition_twoPlusTwo_isFour {
    XCTAssert(2 + 2 == 4, "2 + 2 should be 4");
}

- (void)test_add_fourPlusFour_isEight {
    NSInteger result = [obj plusNum1:4 num2:4];
    XCTAssert(result == 8, @"add fault");
}

- (void)test_multi_fourMultiFour_isSixteen {
    NSInteger result = [obj multiNum1:4 num2:4];
    XCTAssert(result == 16, @"multi fault");
}

@end
