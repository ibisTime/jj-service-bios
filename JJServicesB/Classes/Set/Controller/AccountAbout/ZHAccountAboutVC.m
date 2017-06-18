//
//  ZHAccountAboutVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHAccountAboutVC.h"
#import "ZHSetGroup.h"
#import "ZHSetCell.h"
#import "ZHPwdRelatedVC.h"
#import "ZHChangeMobileVC.h"


@interface ZHAccountAboutVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray <ZHSetGroup *> *groups;

@end

@implementation ZHAccountAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户安全";
    UITableView *accoutnTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:accoutnTableView];
    accoutnTableView.dataSource = self;
    accoutnTableView.delegate = self;
    
    self.groups = @[[self group00]];
    
}

- (ZHSetGroup *)group00 {

    __weak typeof(self) weakSelf = self;
    ZHSetGroup *group = [[ZHSetGroup alloc] init];
    
    ZHSetItem *item00 = [[ZHSetItem alloc] init];
    item00.title = @"修改手机号";
    item00.action = ^(){
    
        ZHChangeMobileVC *vc = [[ZHChangeMobileVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };

    ZHSetItem *item01 = [[ZHSetItem alloc] init];
    item01.title = @"修改登录密码";
    item01.action = ^(){
        
        ZHPwdRelatedVC *vc = [[ZHPwdRelatedVC alloc] initWith:ZHPwdTypeReset];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    ZHSetItem *item02 = [[ZHSetItem alloc] init];
    item02.title = @"修改支付密码";
    item02.action = ^(){
        
        ZHPwdRelatedVC *vc = [[ZHPwdRelatedVC alloc] initWith:ZHPwdTypeTradeReset];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    group.setItems = @[item00,item01,item02];
    return group;
}
#pragma mark-- delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ZHSetItem *item = self.groups[indexPath.section].setItems[indexPath.row];
    if(item.action){
        item.action();
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark-- dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHSetCellId"];
    
    if (!cell) {
        
        cell = [[ZHSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ceZHSetCellIdll"];
        
    }
    cell.setItem = self.groups[indexPath.section].setItems[indexPath.row];
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ZHSetGroup *group = self.groups[section];
    return group.setItems.count;
    
}

@end
