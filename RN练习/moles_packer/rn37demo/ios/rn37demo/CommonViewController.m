//
//  CommonViewController.m
//  rn37demo
//
//  Created by liupuyan on 16/12/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CommonViewController.h"
#import "CommandModel.h"
#import "ReactViewController.h"

@interface CommonViewController ()
/**
 *  dataSource
 */
@property (nonatomic, strong) NSMutableArray *dataItems;
@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"Moles Packer";
  
  __weak typeof(self) weakSelf = self;
    CommandModel *cm1 = [[CommandModel alloc] init];
    cm1.name = @"React Seperated Bridge";
    cm1.subtitle = @"reactseperated bridge";
    cm1.block = ^{
        // 获取bundleURL
        NSURL *jsCoreLocation = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"./build/reactseperatedbridge.ios" ofType:@"jsbundle"]];
        ReactViewController *vc = [[ReactViewController alloc] initWithBundleURL:jsCoreLocation initialProperties:nil launchOptions:nil];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    CommandModel *cm2 = [[CommandModel alloc] init];
    cm2.name = @"React Common Bridge 1";
    cm2.subtitle = @"reactcommon Bridge";
    cm2.block = ^{
        NSURL *jsCoreLocation = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"./build/reactcommonbridge1.ios" ofType:@"jsbundle"]];
        ReactViewController *vc = [[ReactViewController alloc] initWithBundleURL:jsCoreLocation initialProperties:nil launchOptions:nil useCommonBridge:YES];
        [vc loadBusinessBundle];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
  
    CommandModel *cm3 = [[CommandModel alloc] init];
    cm3.name = @"React Common Bridge 2";
    cm3.subtitle = @"reactcommon Bridge";
    cm3.block = ^{
        NSURL *jsCoreLocation = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"./build/reactcommonbridge2.ios" ofType:@"jsbundle"]];
        ReactViewController *vc = [[ReactViewController alloc] initWithBundleURL:jsCoreLocation initialProperties:nil launchOptions:nil useCommonBridge:YES];
        [vc loadBusinessBundle];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.dataItems addObjectsFromArray:@[cm1, cm2, cm3]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CommandCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    CommandModel *command = [self.dataItems objectAtIndex:indexPath.row];
    cell.textLabel.text = command.name;
    cell.detailTextLabel.text = command.subtitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 70.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommandModel *cm = (CommandModel *)self.dataItems[indexPath.row];
    cm.block();
}

- (NSMutableArray *)dataItems {
  if(!_dataItems) {
    _dataItems = [[NSMutableArray alloc] init];
  }
  return _dataItems;
}

@end
