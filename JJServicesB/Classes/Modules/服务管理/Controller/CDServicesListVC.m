//
//  CDServicesListVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServicesListVC.h"
#import "CDServiceBaseModel.h"
#import "CDDefaultCell.h"
#import "TLPageDataHelper.h"
#import "CDShootServicesModel.h"

#import "ShootServicesVC.h"
#import "EduServicesVC.h"
#import "CDServiceBaseModel.h"
#import "CDOperationServicesModel.h"
#import "OperationServicesVC.h"


@interface CDServicesListVC ()

@property (nonatomic,strong) TLTableView *mineTableView; //商品
@property (nonatomic, strong) NSMutableArray <CDServiceBaseModel *> *models;

@end

@implementation CDServicesListVC

- (void)beginRefresh {

    [self.mineTableView beginRefreshing];

}

//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //普通商品
    TLTableView *goodsTableView = [TLTableView tableViewWithframe:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) delegate:self dataSource:self];
    [self.view addSubview:goodsTableView];
    goodsTableView.rowHeight = [CDDefaultCell rowHeight];
    self.mineTableView = goodsTableView;
    
    //
    __weak typeof(self) weakself = self;
    TLPageDataHelper *goodsHelper = [[TLPageDataHelper alloc] init];
    
    switch (self.type) {
        case ServicesTypeShoot:
            
            goodsHelper.code = @"612086";
            [goodsHelper modelClass:[CDShootServicesModel class]];

            break;
            
        case ServicesTypeEdu:
            
            goodsHelper.code = @"612096";
            [goodsHelper modelClass:[CDEduServicesModel class]];

            break;
            
        case ServicesTypeOperation:
            
            goodsHelper.code = @"612116";
            [goodsHelper modelClass:[CDOperationServicesModel class]];

            break;
            

    }
    
    goodsHelper.parameters[@"publisher"] = [ZHUser user].userId;
    goodsHelper.tableView = self.mineTableView;
    goodsHelper.limit = 10;
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

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        TLNetworking *http = [TLNetworking new];
        http.showView = self.view;
        
        
        switch (self.type) {
            case ServicesTypeShoot: {
                 http.code = @"612081";
            } break;
                
            case ServicesTypeEdu: {
                http.code = @"612091";

                
            } break;
  
            case ServicesTypeOperation: {
                http.code = @"612111";

                
            } break;
        }
        
        http.parameters[@"code"] = self.models[indexPath.row].code;
        [http postWithSuccess:^(id responseObject) {
            
            [self.models removeObjectAtIndex:indexPath.row];
            [(TLTableView *)tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
        }];
        
    }];
    
    return @[rowAction];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.type) {
        case ServicesTypeShoot: {
        
            ShootServicesVC *vc = [[ShootServicesVC alloc] init];
            vc.shootModel = (CDShootServicesModel *)self.models[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            
            [vc setSuccess:^{
                
                [self.mineTableView beginRefreshing];
                
            }];
        }
  
        break;
            
        case ServicesTypeEdu: {
        
            EduServicesVC *vc = [[EduServicesVC alloc] init];
            vc.eduModel = (CDEduServicesModel *)self.models[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            [vc setSuccess:^{
                [self.mineTableView beginRefreshing];
            }];
        }

            break;
            
        case ServicesTypeOperation: {
        
            OperationServicesVC *vc = [[OperationServicesVC alloc] init];
            vc.operationModel = (CDOperationServicesModel *)self.models[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            [vc setSuccess:^{
                
                [self.mineTableView beginRefreshing];
                
            }];
        }
            
            break;
            
    }

    
//    CDUIServicesVC *vc = [CDUIServicesVC new];
//    vc.servicesBaseModel = self.models[indexPath.row];
//    
//    //     *vc = [[CDServiceTypeChooseVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//
    
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
    
    CDServiceBaseModel *model = self.models[indexPath.row];
    
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:[model.advPic convertThumbnailImageUrl]]];
    cell.mainTextLbl.text = model.name;
    cell.subTextLbl.text = [NSString stringWithFormat:@"报价：%@-%@",[model.quoteMin convertToRealMoney],[model.quoteMax convertToRealMoney]];
    cell.stateLbl.text = [model getStatusName];
    if (model.dealNote) {
        
        cell.timeLbl.text = [NSString stringWithFormat:@"违规原因：%@",model.dealNote];

    }
    return cell;
    
}



@end
