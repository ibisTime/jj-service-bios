//
//  TypeChooseVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TypeChooseVC.h"

@interface TypeChooseVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TypeChooseVC

- (void)viewDidLoad {

    [super viewDidLoad];
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:tv];
    
    tv.delegate =  self;
    tv.dataSource = self;

}

-(NSArray <TypeModel *> *)typeArrays {

    if (!_typeArrays) {
        
        _typeArrays = [NSArray array];
    }
    
    return _typeArrays;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selected) {
        
        self.selected(self.typeArrays[indexPath.row]);
        
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.typeArrays.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellId"];
    }
    
    TypeModel *model = self.typeArrays[indexPath.row];
    cell.textLabel.text = model.key;
    return cell;
    
}


@end
