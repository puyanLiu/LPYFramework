//
//  ViewController.m
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController () {
    sqlite3 *_db; // db数据库实例
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获得沙盒中的数据库文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"student.sqlite"];
    
    // 创建/打开数据库(不存在就创建)
    int result = sqlite3_open(filename.UTF8String, &_db);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        // 创建表
        const char *sql = "create table if not exists t_student (id integer primary key autoincrement, name text, age integer);";
        char *errorMsg = NULL;
        int result = sqlite3_exec(_db, sql, NULL, NULL, &errorMsg);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建学生表");
        } else {
            NSLog(@"创建学生表失败 %s", errorMsg);
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (IBAction)btn_InsertClick:(id)sender {
    for(int i = 0; i < 30; i++) {
        NSString *name = [NSString stringWithFormat:@"Jack-%d", arc4random()%100];
        int age = arc4random()%100;
        NSString *sql = [NSString stringWithFormat:@"insert into t_student (name, age) values('%@', %d);", name, age];
        
        char *errorMesg = NULL;
        int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMesg);
        if (result == SQLITE_OK) {
            NSLog(@"成功添加数据");
        } else {
            NSLog(@"添加数据失败:%s", errorMesg);
        }
    }
}

- (IBAction)btn_UpdateClick:(id)sender {
}

- (IBAction)btn_DeleteClick:(id)sender {
}

- (IBAction)btn_SearchClick:(id)sender {
    // SQL注入漏洞
    
    /**
     登录功能
     
     1.用户输入账号和密码
     * 账号：123' or 1 = 1 or '' = '
     * 密码：456654679
     
     2.拿到用户输入的账号和密码去数据库查询（查询有没有这个用户名和密码）
     select * from t_user where username = '123' and password = '456';
     
     
     select * from t_user where username = '123' and password = '456';
     */
    
    // 1.定义sql语句
    const char *sql = "select id, name, age from t_student where name = ?;";
    
    // 2.定义一个stmt存放结果集
    sqlite3_stmt *stmt = NULL;
    
    // 3.检测SQL语句的合法性
    int result = sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"查询语句是合法的");
        
        // 设置占位符的内容
        sqlite3_bind_text(stmt, 1, "jack", -1, NULL);
        
        // 4.执行SQL语句，从结果集中取出数据
        //        int stepResult = sqlite3_step(stmt);
        while (sqlite3_step(stmt) == SQLITE_ROW) { // 真的查询到一行数据
            // 获得这行对应的数据
            
            // 获得第0列的id
            int sid = sqlite3_column_int(stmt, 0);
            
            // 获得第1列的name
            const unsigned char *sname = sqlite3_column_text(stmt, 1);
            
            // 获得第2列的age
            int sage = sqlite3_column_int(stmt, 2);
            
            NSLog(@"%d %s %d", sid, sname, sage);
        }
    } else {
        NSLog(@"查询语句非合法");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
