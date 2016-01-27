//
//  LPYDecoratorPatternViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYDecoratorPatternViewController.h"
#import "LPYGamePad.h"
#import "LPYGamePadDecorator.h"
#import "LPYCheatGamePadDecorator.h"
#import "LPYGamePad+LPYCheat.h"
#import "LPYGamePad+LPYCoin.h"

@interface LPYDecoratorPatternViewController ()

@end

@implementation LPYDecoratorPatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LPYGamePad *gamePad = [[LPYGamePad alloc] init];
    [gamePad up];
    
    [gamePad cheat];
    
    gamePad.coin = 10;
    NSLog(@"coin %ld", gamePad.coin);
    
    LPYGamePadDecorator *gamePadDecorator = [[LPYGamePadDecorator alloc] init];
    [gamePadDecorator up];
    
    LPYCheatGamePadDecorator *cheatGamePadDecorator = [[LPYCheatGamePadDecorator alloc] init];
    [cheatGamePadDecorator cheat];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
