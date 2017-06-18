//
//  ZHGoodsListVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2017/1/11.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServiceMgtVC.h"
#import "TLPageDataHelper.h"
#import "CDDefaultCell.h"
#import "CDServicesInfoChangeVC.h"


@interface CDServiceMgtVC ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic,strong) NSMutableArray *models; //商品
@property (nonatomic,assign) BOOL isFirst;


//@property (nonatomic,strong) NSMutableArray <ZHGoodsModel *> *treasureModels; //商品
@property (nonatomic,strong) TLTableView *mineTableView; //商品

@end

@implementation CDServiceMgtVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.isFirst) {
        
        self.isFirst = NO;
        [self.mineTableView beginRefreshing];
        //        [self.treasureTableView beginRefreshing];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFirst = YES;
    self.models = [NSMutableArray array];
    [self.models addObject:@2];
    
 
    //普通商品
    TLTableView *goodsTableView = [TLTableView tableViewWithframe:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) delegate:self dataSource:self];
    [self.view addSubview:goodsTableView];
    goodsTableView.rowHeight = [CDDefaultCell rowHeight];
    self.mineTableView = goodsTableView;

    
    
    
    ///
    __weak typeof(self) weakself = self;
    TLPageDataHelper *goodsHelper = [[TLPageDataHelper alloc] init];
    goodsHelper.code = @"808025";
    goodsHelper.isAutoDeliverCompanyCode = NO;
    goodsHelper.parameters[@"companyCode"] = [ZHUser user].userId;
//    [goodsHelper modelClass:[ZHGoodsModel class]];
    goodsHelper.tableView = self.mineTableView;
    
    self.mineTableView.placeHolderView = [TLPlaceholderView placeholderViewWithText:@"暂无记录"];
    
    [self.mineTableView addRefreshAction:^{
        
        [goodsHelper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
//            weakself.models = objs;
//            [weakself.mineTableView reloadData_tl];
            
            
        } failure:^(NSError *error) {
            
            
        }];
        
    }];
    
    
    [self.mineTableView addLoadMoreAction:^{
        
        [goodsHelper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            
//            weakself.models = objs;
//            [weakself.mineTableView reloadData_tl];
            
            
        } failure:^(NSError *error) {
            
            
        }];
    }];
    
    
}


- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self.models removeObjectAtIndex:indexPath.row];
        [(TLTableView *)tableView reloadData_tl];
        
    }];

    return @[rowAction];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CDServicesInfoChangeVC *vc = [[CDServicesInfoChangeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.models.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CDDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHGoodsCellId"];
    if (!cell) {
        
        cell = [[CDDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZHGoodsCellId"];
    }
    
    cell.imageView.backgroundColor = [UIColor orangeColor];
    cell.mainTextLbl.text = @"主要";
    cell.subTextLbl.text = @"次要";
    cell.timeLbl.text = @"2019-23-32";
    cell.stateLbl.text = @"状态";

    return cell;
    
}

@end
