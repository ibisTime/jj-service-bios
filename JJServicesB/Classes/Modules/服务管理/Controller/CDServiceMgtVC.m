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
//#import "CDServicesInfoChangeVC.h"
#import "CDServicesHelper.h"
#import "CDServiceTypeChooseVC.h"
#import "CDServiceBaseModel.h"
#import "CDUIServicesVC.h"
#import "ZHSegmentView.h"
#import "CDServicesListVC.h"
#import "ZHNavigationController.h"

#import "ShootServicesVC.h"
#import "EduServicesVC.h"
#import "OperationServicesVC.h"


@interface CDServiceMgtVC ()<ZHSegmentViewDelegate>


//@property (nonatomic,strong) NSMutableArray *models; //商品
//@property (nonatomic,assign) BOOL isFirst;
//
////@property (nonatomic,strong) NSMutableArray <ZHGoodsModel *> *treasureModels; //商品
//@property (nonatomic,strong) TLTableView *mineTableView; //商品
//@property (nonatomic, strong) NSMutableArray <CDServiceBaseModel *> *models;

@property (nonatomic, strong) UIScrollView *switchScrollView;
@property (nonatomic, strong) CDServicesListVC *listVC;

@end

@implementation CDServiceMgtVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    if (self.isFirst) {
//        
//        self.isFirst = NO;
//        [self.mineTableView beginRefreshing];
//        //        [self.treasureTableView beginRefreshing];
//        
//    }
    
}

- (BOOL)segmentSwitch:(NSInteger)idx {

    [self.switchScrollView setContentOffset:CGPointMake(idx*SCREEN_WIDTH, 0)];
    
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.isFirst = YES;
//    self.models = [NSMutableArray array];
    self.title = @"服务管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:0 target:self action:@selector(add)];
    
//    ZHSegmentView *segmentView = [[ZHSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
//    segmentView.delegate = self;
//    [self.view addSubview:segmentView];
//    segmentView.tagNames = @[@"摄影",@"培训",@"运营"];
//    segmentView.bootomLine.backgroundColor = [UIColor themeColor];
    
    //
//    UIScrollView *switchScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, segmentView.height, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - segmentView.height)];
//    [self.view addSubview:switchScrollView];
//    switchScrollView.contentSize = CGSizeMake(3*SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 45);
//    self.switchScrollView = switchScrollView;
//    switchScrollView.pagingEnabled = YES;
//    switchScrollView.scrollEnabled = NO;
    
    
    if ([[CDCompany company].gsQualify.qualifyCode isEqualToString:SHOOT_APTITUDE_KEY]) {
        
        //摄影
        CDServicesListVC *syVC = [[CDServicesListVC alloc] init];
        syVC.type = ServicesTypeShoot;
        syVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self.view addSubview:syVC.view];
        [self addChildViewController:syVC];
        [syVC beginRefresh];
        self.listVC = syVC;
        
    } else if ([[CDCompany company].gsQualify.qualifyCode isEqualToString:EDU_APTITUDE_KEY]) {
    
      
        //培训
        CDServicesListVC *eduVC = [[CDServicesListVC alloc] init];
        eduVC.type = ServicesTypeEdu;
        eduVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self.view addSubview:eduVC.view];
        [self addChildViewController:eduVC];
        [eduVC beginRefresh];
        self.listVC = eduVC;

    
    
    } else if ([[CDCompany company].gsQualify.qualifyCode isEqualToString:OPERATION_APTITUDE_KEY]) {
    
        //运营
        CDServicesListVC *operationVC = [[CDServicesListVC alloc] init];
        operationVC.type = ServicesTypeOperation;
        operationVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self.view addSubview:operationVC.view];
        [self addChildViewController:operationVC];
        [operationVC beginRefresh];
        self.listVC = operationVC;

    }
  
    


    


  
    //
//    //普通商品
//    TLTableView *goodsTableView = [TLTableView tableViewWithframe:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) delegate:self dataSource:self];
//    [self.view addSubview:goodsTableView];
//    goodsTableView.rowHeight = [CDDefaultCell rowHeight];
//    self.mineTableView = goodsTableView;
//
//    //
//    __weak typeof(self) weakself = self;
//    TLPageDataHelper *goodsHelper = [[TLPageDataHelper alloc] init];
//    goodsHelper.code = @"612140";
////    goodsHelper.isAutoDeliverCompanyCode = NO;
////    goodsHelper.parameters[@"companyCode"] = [ZHUser user].userId;
//    [goodsHelper modelClass:[CDServiceBaseModel class]];
//    goodsHelper.tableView = self.mineTableView;
//    self.mineTableView.placeHolderView = [TLPlaceholderView placeholderViewWithText:@"暂无记录"];
//    
//    [self.mineTableView addRefreshAction:^{
//        
//        [goodsHelper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//            
//            weakself.models = objs;
//            [weakself.mineTableView reloadData_tl];
//            
//            
//        } failure:^(NSError *error) {
//            
//            
//        }];
//        
//    }];
//    
//    
//    [self.mineTableView addLoadMoreAction:^{
//        
//        [goodsHelper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
//            
//            weakself.models = objs;
//            [weakself.mineTableView reloadData_tl];
//            
//            
//        } failure:^(NSError *error) {
//            
//            
//        }];
//    }];
    
    
}

#pragma mark- 添加服务
- (void)add {

    if ([[CDCompany company].gsQualify.qualifyCode isEqualToString:SHOOT_APTITUDE_KEY]) {
        
        ShootServicesVC *vc = [ShootServicesVC new];
        [self.navigationController pushViewController:vc animated:YES];
        [vc setSuccess:^{
            [self.listVC beginRefresh];
        }];
        
        
    } else if ([[CDCompany company].gsQualify.qualifyCode isEqualToString:EDU_APTITUDE_KEY]) {
        
        
        EduServicesVC *vc = [EduServicesVC new];
        [self.navigationController pushViewController:vc animated:YES];
        [vc setSuccess:^{
            [self.listVC beginRefresh];
        }];
        
        
    } else if ([[CDCompany company].gsQualify.qualifyCode isEqualToString:OPERATION_APTITUDE_KEY]) {
        
    
        OperationServicesVC *vc = [OperationServicesVC new];
        [self.navigationController pushViewController:vc animated:YES];
        [vc setSuccess:^{
            [self.listVC beginRefresh];
        }];
        
    }

    
    
//    CDServiceTypeChooseVC *vc = [CDServiceTypeChooseVC new];
//    
//    //
//    ZHNavigationController *nav = [[ZHNavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
//    
//    [vc setSelected:^(NSInteger idx){
//        
//        if (idx == 0) {
//            
//       
//            
//        } else if (idx == 1) {
//            
//        
//            
//        } else if (idx == 2) {
//            
//      
//            
//            
//        }
//        
//    }];
    
    

}

//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//        TLNetworking *http = [TLNetworking new];
//        http.showView = self.view;
//        http.code = @"612130";
//        http.parameters[@"code"] = @"";
//        [http postWithSuccess:^(id responseObject) {
//            
//            [self.models removeObjectAtIndex:indexPath.row];
//            [(TLTableView *)tableView reloadData_tl];
//            
//        } failure:^(NSError *error) {
//            
//        }];
//
//
//        
//    }];
//
//    return @[rowAction];
//
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    CDUIServicesVC *vc = [CDUIServicesVC new];
//    vc.servicesBaseModel = self.models[indexPath.row];
//    
////     *vc = [[CDServiceTypeChooseVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//}
//
//#pragma mark- dataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return self.models.count;
//    
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CDDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHGoodsCellId"];
//    if (!cell) {
//        
//        cell = [[CDDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZHGoodsCellId"];
//    }
//    
//    cell.imageView.backgroundColor = [UIColor orangeColor];
//    
//    CDServiceBaseModel *model = self.models[indexPath.row];
//    
//    cell.mainTextLbl.text = model.name;
//    cell.subTextLbl.text = [NSString stringWithFormat:@"%@",model.quoteMax];
//    cell.stateLbl.text = @"状态";
//    
//    return cell;
//    
//}

@end
