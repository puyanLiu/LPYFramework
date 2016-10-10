//
//  DataBaseTool.m
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "DataBaseTool.h"
#import <sqlite3.h>

@implementation DataBaseTool

// static的作用：能保证_db这个变量只被IWStudentTool.m直接访问
static sqlite3 *_db;

+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"student.sqlite"];
    
    // 1.创建(打开)数据库（如果数据库文件不存在，会自动创建）
    int result = sqlite3_open(filename.UTF8String, &_db);
    if (result == SQLITE_OK) {
        NSLog(@"成功打开数据库");
        
        // 2.创表
        const char *sql = "create table if not exists t_student (id integer primary key autoincrement, name text, age integer);";
        char *errorMesg = NULL;
        int result = sqlite3_exec(_db, sql, NULL, NULL, &errorMesg);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建t_student表");
            
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
            
        } else {
            NSLog(@"创建t_student表失败:%s", errorMesg);
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

+ (BOOL)addStudent:(StudentModel *)student
{
    NSString *sql = [NSString stringWithFormat:@"insert into t_student (name, age) values('%@', %d);", student.name, student.age];
    
    char *errorMesg = NULL;
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMesg);
    
    return result == SQLITE_OK;
}

+ (NSArray *)students
{
    // 0.定义数组
    NSMutableArray *students = nil;
    
    // 1.定义sql语句
    const char *sql = "select id, name, age from t_student;";
    
    // 2.定义一个stmt存放结果集
    sqlite3_stmt *stmt = NULL;
    
    // 3.检测SQL语句的合法性
    int result = sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"查询语句是合法的");
        students = [NSMutableArray array];
        
        // 4.执行SQL语句，从结果集中取出数据
        while (sqlite3_step(stmt) == SQLITE_ROW) { // 真的查询到一行数据
            // 获得这行对应的数据
            
            StudentModel *student = [[StudentModel alloc] init];
            
            // 获得第0列的id
            student.ID = sqlite3_column_int(stmt, 0);
            
            // 获得第1列的name
            const unsigned char *sname = sqlite3_column_text(stmt, 1);
            student.name = [NSString stringWithUTF8String:(const char *)sname];
            
            // 获得第2列的age
            student.age = sqlite3_column_int(stmt, 2);
            
            // 添加到数组
            [students addObject:student];
        }
    } else {
        NSLog(@"查询语句非合法");
    }
    
    return students;
}

+ (NSArray *)studentsWithCondition:(NSString *)condition
{
    // 0.定义数组
    NSMutableArray *students = nil;
    
    // 1.定义sql语句
    const char *sql = "select id, name, age from t_student where name like ?;";
    
    // 2.定义一个stmt存放结果集
    sqlite3_stmt *stmt = NULL;
    
    // 3.检测SQL语句的合法性
    int result = sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"查询语句是合法的");
        students = [NSMutableArray array];
        
        // 填补占位符的内容
        NSString *newCondition = [NSString stringWithFormat:@"%%%@%%", condition];
        //        NSLog(@"%@", newCondition);
        sqlite3_bind_text(stmt, 1, newCondition.UTF8String, -1, NULL);
        
        // 4.执行SQL语句，从结果集中取出数据
        while (sqlite3_step(stmt) == SQLITE_ROW) { // 真的查询到一行数据
            // 获得这行对应的数据
            
            StudentModel *student = [[StudentModel alloc] init];
            
            // 获得第0列的id
            student.ID = sqlite3_column_int(stmt, 0);
            
            // 获得第1列的name
            const unsigned char *sname = sqlite3_column_text(stmt, 1);
            student.name = [NSString stringWithUTF8String:(const char *)sname];
            
            // 获得第2列的age
            student.age = sqlite3_column_int(stmt, 2);
            
            // 添加到数组
            [students addObject:student];
        }
    } else {
        NSLog(@"查询语句非合法");
    }
    
    return students;
}
@end
