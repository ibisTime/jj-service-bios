//
//  CDServiceTypeChooseVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServiceTypeChooseVC.h"
#import "CDUIServicesVC.h"

#import "ShootServicesVC.h"
#import "EduServicesVC.h"
#import "OperationServicesVC.h"


@interface CDServiceTypeChooseVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSArray *names;

@end

@implementation CDServiceTypeChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TLTableView *tableView = [[TLTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.names= @[@"摄影",@"培训",@"运营"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ShootServicesVC *vc = [ShootServicesVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 1) {
    
        EduServicesVC *vc = [EduServicesVC new];
        [self.navigationController pushViewController:vc animated:YES];
    
    } else if (indexPath.row == 2) {
    
        OperationServicesVC *vc = [OperationServicesVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    
    }


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.names.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellId"];
        
    }
    cell.textLabel.text = self.names[indexPath.row];
    
    return cell;

}

@end
