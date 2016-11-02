//
//  ViewController.m
//  paomadeng
//
//  Created by liupuyan on 16/11/2.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "ViewController.h"
#import "MarqueeView.h"
#import "SystemNoticeModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *systemNoticeList = [NSMutableArray array];
    
    SystemNoticeModel *model = [[SystemNoticeModel alloc] init];
    model.title = @"消费分";
    [systemNoticeList addObject:model];
    SystemNoticeModel *model1 = [[SystemNoticeModel alloc] init];
    model1.title = @"哈哈哈";
    [systemNoticeList addObject:model1];
//    SystemNoticeModel *model2 = [[SystemNoticeModel alloc] init];
//    model2.title = @"你说你在干什么啊啊，啦啦啦啦啦了哈哈";
//    [systemNoticeList addObject:model2];
    
    NSMutableArray *viewArray = [NSMutableArray array];
    [systemNoticeList enumerateObjectsUsingBlock:^(SystemNoticeModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        // 公告
        UILabel * label = [[UILabel alloc] init];
        label.text = model.title;
        label.tag = idx;
        label.userInteractionEnabled = YES;
        [label sizeToFit];
        [viewArray addObject:label];
    }];
    
    MarqueeView * marquee = [[MarqueeView alloc] initWithFrame:CGRectMake(10, 100, 360, 30)];
    marquee.backgroundColor = [UIColor grayColor];
    marquee.scrollDirection = MarqueeViewScrollDirectionHorizontal;
    marquee.views = viewArray;
    [self.view addSubview:marquee];
    [marquee fire];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
