//
//  BaseSqlManager.h
//  sql_test
//
//  Created by 铁血-mac on 2017/10/25.
//  Copyright © 2017年 tiexue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BaseSqlManager : NSObject

@property (nonatomic,assign)sqlite3 * database;
@property (nonatomic,copy)  NSString * path;

@end
