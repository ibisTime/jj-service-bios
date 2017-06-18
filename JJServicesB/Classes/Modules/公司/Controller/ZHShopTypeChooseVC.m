//
//  ZHShopTypeChooseVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/19.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHShopTypeChooseVC.h"

@interface ZHShopTypeChooseVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZHShopTypeChooseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺类型选择";
    
    //
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    //(1 美食 2 KTV 3 电影 4 酒店 5 休闲娱乐 6 汽车 7 周边游 8 足疗按摩 9 生活服务 10 旅游)

//   _typeNames = @[@"美食",@"KTV",@"电影",@"酒店",@"休闲娱乐",@"汽车",@"周边游",@"足疗按摩",@"生活服务",@"旅游"];
//   _typeNames = @[@"美食",@"KTV",@"美发",@"便利店",@"足浴",@"酒店",@"亲子",@"蔬果"];
//    _imgNames = @[@"美食",@"KTV",@"电影",@"酒店",@"休闲娱乐",@"汽车",@"周边游",@"足疗按摩",@"生活服务",@"旅游"];
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.selectedType) {
//        self.selectedType([ZHShop shop].shopTypes[indexPath.row].name,[ZHShop shop].shopTypes[indexPath.row].code);
        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    return [ZHShop shop].shopTypes.count;
    return 10;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *shopTypeId = @"shopTypeId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopTypeId];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopTypeId];
        
//        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
//        [cell.imageView addSubview:icon];
//        icon.backgroundColor = [UIColor orangeColor];
        cell.textLabel.textColor = [UIColor zh_textColor];
        cell.textLabel.font = [UIFont secondFont];
        
    }
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    cell.imageView.image = [UIImage imageNamed:@"user"];
    
//    cell.textLabel.text = [ZHShop shop].shopTypes[indexPath.row].name;
    return cell;
    
}


@end
