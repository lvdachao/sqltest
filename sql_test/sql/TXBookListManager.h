//
//  TXBookListManager.h
//  sql_test
//
//  Created by 铁血-mac on 2017/10/25.
//  Copyright © 2017年 tiexue. All rights reserved.
//

#import "BaseSqlManager.h"

@interface TXBookListManager : BaseSqlManager

/**
  增加数据

 @param datadict 字典数据
 */
- (void)insetBooklist:(NSDictionary *)datadict;


/**
 更新数据

 @param datadict 所要更新的数据
 @param bookid 书的id
 */
- (void)updateData:(NSDictionary *)datadict withBooKid:(NSString *)bookid;

// 删除

/**
 删除

 @param bookId 所删除书籍id
 */
- (void)deleteBookId:(NSString *)bookId;

/**
 数据表内添加字段

 @param fieldDict 字典 key：所要的字段 value：字段类型
 */
- (void)addfield:(NSDictionary *)fieldDict;

/**
 按最后时间获取所有数据

 @return 数据数组
 */
- (NSArray *)getAllDataByLastTime;

@end
