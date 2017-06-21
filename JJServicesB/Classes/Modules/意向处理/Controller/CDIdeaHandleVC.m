//
//  ZHGoodsListVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2017/1/11.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDIdeaHandleVC.h"
#import "TLPageDataHelper.h"
#import "CDDefaultCell.h"
#import "CDIdeaDetailVC.h"
#import "CDIdeaModel.h"


@interface CDIdeaHandleVC ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic,strong) NSMutableArray <CDIdeaModel *>*models; //商品
@property (nonatomic,assign) BOOL isFirst;


//@property (nonatomic,strong) NSMutableArray <ZHGoodsModel *> *treasureModels; //商品
@property (nonatomic,strong) TLTableView *mineTableView; //商品

@end

@implementation CDIdeaHandleVC

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
//    self.models = [NSMutableArray array];
    self.title  = @"意向处理";
    
    //普通商品
    TLTableView *goodsTableView = [TLTableView tableViewWithframe:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) delegate:self dataSource:self];
    [self.view addSubview:goodsTableView];
    goodsTableView.rowHeight = [CDDefaultCell rowHeight];
    self.mineTableView = goodsTableView;
    
    
    
    
    ///
    __weak typeof(self) weakself = self;
    TLPageDataHelper *goodsHelper = [[TLPageDataHelper alloc] init];
    goodsHelper.code = @"612175";
    goodsHelper.tableView = self.mineTableView;
    goodsHelper.parameters[@"companyCode"] = [CDCompany company].code;
    [goodsHelper modelClass:[CDIdeaModel class]];
    
    
    self.mineTableView.placeHolderView = [TLPlaceholderView placeholderViewWithText:@"暂无记录"];
    
    [self.mineTableView addRefreshAction:^{
        
        [goodsHelper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
                        weakself.models = objs;
                        [weakself.mineTableView reloadData_tl];
            
            
        } failure:^(NSError *error) {
            
            
        }];
        
    }];
    
    
    [self.mineTableView addLoadMoreAction:^{
        
        [goodsHelper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            
                        weakself.models = objs;
                        [weakself.mineTableView reloadData_tl];
            
            
        } failure:^(NSError *error) {
            
            
        }];
    }];
    
    
}


//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//        [self.models removeObjectAtIndex:indexPath.row];
//        [(TLTableView *)tableView reloadData_tl];
//        
//    }];
//    
//    return @[rowAction];
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CDIdeaDetailVC *ideaVC = [CDIdeaDetailVC new];
    [self.navigationController pushViewController:ideaVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ideaVC.model = self.models[indexPath.row];
    [ideaVC setSuccess:^{
        [self.mineTableView beginRefreshing];
    }];
    
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
    
    CDIdeaModel *model = self.models[indexPath.row];
    
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:[model.logo convertThumbnailImageUrl]]];
    cell.mainTextLbl.text = model.intName;
    cell.subTextLbl.text = [model.submitDatetime convertToDetailDate];
//    cell.timeLbl.text = @"2019-23-32";
    cell.stateLbl.text = [model getStatusName];
    return cell;
    
}

@end
