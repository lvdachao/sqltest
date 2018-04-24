//
//  ViewController.m
//  sql_test
//
//  Created by 铁血-mac on 2017/10/25.
//  Copyright © 2017年 tiexue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TXBookListManager.h"

#define PATH  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"team.sqlite"]

@interface ViewController : UIViewController

@property(strong,nonatomic)UIButton *showbtn;
@property(strong,nonatomic)UIButton *insertbtn;
@property(strong,nonatomic)UIButton *updatebtn;
@property(strong,nonatomic)UIButton *deletebtn;
@property(strong,nonatomic)UIButton *addButton;
@property(strong,nonatomic)UIButton *showButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取沙盒 Documents文件路径
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
    [self button];
}
-(void)button
{
    //
    self.showbtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.showbtn.frame=CGRectMake(100, 50, 200, 50);
    [self.showbtn setTitle:@"创建数据库" forState:UIControlStateNormal];
    [self.showbtn addTarget:self action:@selector(showSql) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showbtn];
    //
    self.insertbtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.insertbtn.frame=CGRectMake(100, 100, 200, 50);
    [self.insertbtn setTitle:@"添加数据" forState:UIControlStateNormal];
    [self.insertbtn addTarget:self action:@selector(insertSql) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.insertbtn];
    //
    self.updatebtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.updatebtn.frame=CGRectMake(100, 150, 200, 50);
    [self.updatebtn setTitle:@"数据库修改" forState:UIControlStateNormal];
    [self.updatebtn addTarget:self action:@selector(updateSql) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.updatebtn];
    //
    self.deletebtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.deletebtn.frame=CGRectMake(100, 200, 200, 50);
    [self.deletebtn setTitle:@"数据库删除" forState:UIControlStateNormal];
    [self.deletebtn addTarget:self action:@selector(deleteSql) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deletebtn];
    //
    self.addButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.addButton.frame=CGRectMake(100, 250, 200, 50);
    [self.addButton setTitle:@"数据库添加字段" forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addSql) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    //
    self.showButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.showButton.frame=CGRectMake(100, 300, 200, 50);
    [self.showButton setTitle:@"展示数据" forState:UIControlStateNormal];
    [self.showButton addTarget:self action:@selector(allSql) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showButton];
}
#pragma mark - 显示数据表中的所有信息
- (void)showSql
{
    TXBookListManager *bookList = [[TXBookListManager alloc] init];
    bookList = nil;
}

#pragma mark -增加信息
- (void)insertSql
{
    TXBookListManager *bookList = [[TXBookListManager alloc] init];
    [bookList insetBooklist:@{@"bookid":[NSNumber numberWithDouble:123],
                              @"number":@"123",
                              @"bookname":[NSString stringWithFormat:@"我要的爱爱:%ld",time(NULL)],
                              @"introduction":@"青春偶像剧",
                              @"author":@"chaochao",
                              @"lastread":[NSString stringWithFormat:@"%ld",time(NULL)]}];
}

#pragma mark - 修改数据库
- (void)updateSql
{
    TXBookListManager *bookList = [[TXBookListManager alloc] init];
    [bookList updateData:@{@"author":@"超哥哥"} withBooKid:@"123"];
}

- (void)deleteSql
{
    TXBookListManager *bookList = [[TXBookListManager alloc] init];
    [bookList deleteBookId:@"123"];
}

- (void)addSql{
    TXBookListManager *bookList = [[TXBookListManager alloc] init];
    [bookList addfield:@{@"fisttime":@"date",@"lastread":@"date"}];
}
- (void)allSql{
    TXBookListManager *bookList = [[TXBookListManager alloc] init];
    NSArray *arr = [bookList getAllDataByLastTime];
    NSNumber *number = arr[0][@"bookid"];
//    NSString *ssss = [number stringValue];
    NSLog(@"%@",arr);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
