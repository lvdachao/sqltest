//
//  TXBookListManager.m
//  sql_test
//
//  Created by 铁血-mac on 2017/10/25.
//  Copyright © 2017年 tiexue. All rights reserved.
//

#import "TXBookListManager.h"


@implementation TXBookListManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initdata];
    }
    return self;
}

- (void)initdata{
    char *error;
    
    //    建表格式: create table if not exists 表名 (列名 类型,....)    注: 如需生成默认增加的id: id integer primary key autoincrement
    const char *createSQL = "create table if not exists booklist(id integer primary key autoincrement,bookid int NOT NULL,lastread,test)";
    
    int tableResult = sqlite3_exec(self.database, createSQL, NULL, NULL, &error);
    
    if (tableResult != SQLITE_OK) {
        
        NSLog(@"创建表失败:%s",error);
    }
}

- (void)insetBooklist:(NSDictionary *)dataDict{
    if (dataDict[@"bookid"] == nil) {
        NSLog(@"添加数据有误");
        return;
    }
    char *errmsg = NULL;
    NSString *sqlstring = [NSString stringWithFormat:@"INSERT INTO booklist (bookid,lastread,test) VALUES ('%@','%@','%@')",dataDict[@"bookid"],dataDict[@"lastread"],dataDict[@"test"]];
    int result = sqlite3_exec(self.database, sqlstring.UTF8String, NULL, NULL, &errmsg);
    if (result !=SQLITE_OK) {
        NSLog(@"添加数据失败：%s",errmsg);
    }
}
// 修改数据
- (void)updateData:(NSDictionary *)dataDict withBooKid:(NSString *)bookid{
    if (bookid == nil) {
        NSLog(@"更新数据有误");
        return;
    }
    NSArray *keys = [dataDict allKeys];
    NSMutableString *updaeString = [NSMutableString string];
    for (int i =0;i<keys.count;i++) {
        NSString *qute = @",";
        if (i ==0) {
            qute = @"";
        }
        [updaeString appendString:[NSString stringWithFormat:@"%@%@='%@'",qute,keys[i],dataDict[keys[i]]]];
    }
    NSString *sqlString = [NSString stringWithFormat:@"UPDATE booklist SET %@ WHERE bookid = '%@'",updaeString,bookid];
    char *errmsg = NULL;
    int result = sqlite3_exec(self.database, sqlString.UTF8String, NULL,NULL, &errmsg);
    if (result!=SQLITE_OK) {
        NSLog(@"更新失败");
    }
}

/**
 删除
 
 @param bookId 所删除书籍id
 */
- (void)deleteBookId:(NSString *)bookId{
    if (![bookId isKindOfClass:[NSString class]]|| bookId == nil) {
        return;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM booklist WHERE bookid = '%@'",bookId];
    char *errmsg = NULL;
    int result = sqlite3_exec(self.database, sqlString.UTF8String, NULL, NULL, &errmsg);
    if (result!=SQLITE_OK) {
        NSLog(@"删除失败");
    }
}
/**
 数据表内添加字段
 
 @param fieldDict 字典 key：所要的字段 value：字段类型
 */
- (void)addfield:(NSDictionary *)fieldDict{
    NSArray *fieldsArr = [fieldDict allKeys];
    if (!fieldsArr.count) {
        return;
    }
    for (int i=0; i<fieldsArr.count; i++) {
        NSString *addString = [NSString stringWithFormat:@"%@ %@",fieldsArr[i],fieldDict[fieldsArr[i]]];
        NSString *sqlString = [NSString stringWithFormat:@"ALTER TABLE booklist ADD %@",addString];
        char *errmsg = NULL;
        int result = sqlite3_exec(self.database, sqlString.UTF8String, NULL, NULL, &errmsg);
        if (result!=SQLITE_OK) {
            NSLog(@"添加%@字段失败",fieldsArr[i]);
        }
    }
}

/**
 按最后时间获取所有数据
 
 @return 数据数组
 */
- (NSArray *)getAllDataByLastTime{
    // 需要过滤 
    NSString *sqlString = @"SELECT *  FROM booklist ORDER BY lastread DESC";
    sqlite3_stmt * stmt = nil;
    NSMutableArray *dataArr = [NSMutableArray array];
    int result = sqlite3_prepare_v2(self.database, sqlString.UTF8String, -1, &stmt, NULL);
    if (result==SQLITE_OK) {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(stmt, 0)] forKey:@"id"];
            [dict setValue:[NSNumber numberWithInt:sqlite3_column_int(stmt, 1)] forKey:@"id"];
            [self addDict:dict withContent:stmt withIndex:2 withKey:@"bookname"];
            int sss = sqlite3_column_int(stmt, 3);
//            [self addDict:dict withContent:stmt withIndex:3 withKey:@"introduction"];
            [self addDict:dict withContent:stmt withIndex:4 withKey:@"Birthday"];
            [self addDict:dict withContent:stmt withIndex:5 withKey:@"lasttime"];
            [self addDict:dict withContent:stmt withIndex:6 withKey:@"lastread"];
            [dataArr addObject:dict];
        }
    }
    return dataArr;
}
- (void)addDict:(NSMutableDictionary *)dict withContent:(sqlite3_stmt *)stmt withIndex:(int)index withKey:(NSString *)key{
    const unsigned char *code = sqlite3_column_text(stmt, index);
    if (code) {
        [dict setValue:[NSString stringWithUTF8String:(const char*)code] forKey:key];
    }
}

@end
