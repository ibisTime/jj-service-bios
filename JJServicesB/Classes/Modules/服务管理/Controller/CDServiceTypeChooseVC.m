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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(cancle)];
    
}

- (void)cancle {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selected) {
        self.selected(indexPath.row);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];


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
