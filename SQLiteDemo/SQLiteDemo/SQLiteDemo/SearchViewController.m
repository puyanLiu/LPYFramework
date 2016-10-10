//
//  SearchViewController.m
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "SearchViewController.h"
#import "StudentModel.h"
#import "DataBaseTool.h"

@interface SearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *students;
@end

@implementation SearchViewController

- (NSArray *)students
{
    if (_students == nil) {
        _students = [DataBaseTool students];
    }
    return _students;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
}

#pragma mark - 搜索框代理
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.students = [DataBaseTool studentsWithCondition:searchText];
    [self.tableView reloadData];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *ID = @"student";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 2.设置cell的数据
    StudentModel *stu = self.students[indexPath.row];
    cell.textLabel.text = stu.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", stu.age];
    
    return cell;
}

@end
