//
//  BaseSqlManager.m
//  sql_test
//
//  Created by 铁血-mac on 2017/10/25.
//  Copyright © 2017年 tiexue. All rights reserved.
//

#import "BaseSqlManager.h"

@implementation BaseSqlManager
- (instancetype)init{
    if (self = [super init]) {
        self.path = [NSHomeDirectory() stringByAppendingString:@"/Documents/resderList.sqlite3"];
        [self openSqlite];
    }
    return self;
}
//打开数据库
- (BOOL)openSqlite{
    if (_database==nil) {
        if (sqlite3_open(_path.UTF8String, &_database)==SQLITE_OK) {
            NSLog(@"打开数据库成功");
            return YES;
        }
    }
    return NO;
}
//关闭数据库
- (void)close{
    if (_database) {
        sqlite3_close(_database);
        NSLog(@"关闭数据库dd");
    }
}
- (void)dealloc{
    [self close];
}
@end
