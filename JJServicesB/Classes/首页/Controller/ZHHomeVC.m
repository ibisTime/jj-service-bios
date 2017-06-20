//
//  ZHHomeVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHHomeVC.h"
#import "MJRefresh.h"
#import "ZHMineSetVC.h"
#import "CDShopAptitudesApplyVC.h"
#import "UIButton+WebCache.h"
#import "ZHFuncView.h"
#import "CDServiceMgtVC.h"

#import "ZHSJIntroduceVC.h"
#import "ZHShopInfoChangeVC.h"
#import "CDIdeaHandleVC.h"
#import "ZHMsgVC.h"

@interface ZHHomeVC ()

@property (nonatomic,strong) UILabel *nameLbl;
@property (nonatomic,strong) UILabel *aptitudeNameLbl;

@property (nonatomic,strong) UIButton *photoBtn;
@property (nonatomic,strong) UILabel *capitalLbl;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) ZHFuncView *kefuFuncView;

@property (nonatomic, strong) UIView *aptitudeView;
@property (nonatomic, strong) UILabel *aptitudeInfoLbl;
@property (nonatomic, strong) UILabel *refuseLbl;
@property (nonatomic, strong) UIButton *reApplyBtn;
@property (nonatomic, assign) BOOL isFirst;

@end

@implementation ZHHomeVC
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.isFirst = YES;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:0 target:self action:@selector(loginOut)];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:0 target:self action:@selector(refresh)];
  
    
    [self setPlaceholderViewTitle:@"加载失败" operationTitle:@"重新加载"];
    [self tl_placeholderOperation];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if ([CDCompany company].aptitudeType == AptitudeTypePass) {
        
        [self hiddenNavBar];

        return;
    }
    
    //
//    if (!self.isFirst) {
//        
//        [self hiddenNavBar];
//        
//    } else {
//    
//        self.isFirst = NO;
//    
//    }
    
    
}

- (void)loginOut {

    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginOutNotification object:nil];

}

- (void)hiddenNavBar{

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)goApplyAptitude {

    CDShopAptitudesApplyVC *vc = [[CDShopAptitudesApplyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

    [vc setSuccess:^{
        
        [self.navigationController popViewControllerAnimated:YES];
        [self tl_placeholderOperation];
        
    }];
    
}

- (void)tl_placeholderOperation {
    
    //刚进入还未获取用户信息
    if([CDCompany company].code && [CDCompany company].aptitudeType == AptitudeTypeUnApply) {
    
        [self goApplyAptitude];
        return;
        
    }
    
   
    //1.获取店铺信息
    [TLProgressHUD showWithStatus:nil];
    [[CDCompany company] getShopInfoSuccess:^(NSDictionary *shopDict) {
        
        [TLProgressHUD dismiss];
        
        switch ([CDCompany company].aptitudeType) {
                
            case AptitudeTypeUnApply: { //未申请
                
                [self goApplyAptitude];

                [self setPlaceholderViewTitle:@"您还未申请资质" operationTitle:@"申请"];
                [self addPlaceholderView];
            }
            break;
                
            case AptitudeTypeWillCheck: { //待审核
                
                [self.view addSubview:self.aptitudeView];

                self.aptitudeInfoLbl.text = [NSString stringWithFormat:@"尊敬的%@ \n您申请的%@\n还在审核中，我们将在1-2工作日内回复您",[CDCompany company].corporation,[CDCompany company].gsQualify.qualifyName];
                self.reApplyBtn.hidden = YES;
                self.refuseLbl.text = nil;
                
            }
            break;
        
            //
            case AptitudeTypePass: {
                
                [self removePlaceholderView];
                
                [self hiddenNavBar];
                [self setUpUI];
                [self initData];
                
                //增加通知
                [self addNotification];
                
                //更新用户数据
                [[ZHUser user] updateUserInfo];
                
            }
            break;
            
            //
            case AptitudeTypeRefuse: {//拒绝
                
                [self.view addSubview:self.aptitudeView];
                self.reApplyBtn.hidden = NO;

                self.aptitudeInfoLbl.text = [NSString stringWithFormat:@"尊敬的%@ \n您申请的%@\n还在审核中，我们将在1-2工作日内回复您",[CDCompany company].corporation,[CDCompany company].gsQualify.qualifyName];
                self.refuseLbl.text = [NSString stringWithFormat:@"审核不通过，理由是：%@",[CDCompany company].remark];
                
            }
            break;

        }

    
        
    } failure:^(NSError *error) {
        
        [self addPlaceholderView];
        [TLProgressHUD dismiss];
        
    }];


}

#pragma mark- fresh
- (void)refresh {

    [self tl_placeholderOperation];

}


#pragma mark- 重新申请资质
- (void)reApplyAptitudeAction {

    CDShopAptitudesApplyVC *vc = [[CDShopAptitudesApplyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setSuccess:^{
       
        [self.navigationController popViewControllerAnimated:YES];
        [self refresh];
        
    }];
    
}




//--//
- (UIView *)aptitudeView {

    if (!_aptitudeView) {
        
        
        UIView *applyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _aptitudeView = applyView;
        applyView.backgroundColor = [UIColor whiteColor];

        UILabel *lbl1 = [UILabel labelWithFrame:CGRectZero
                                   textAligment:NSTextAlignmentLeft
                                backgroundColor:[UIColor whiteColor]
                                           font:FONT(15)
                                      textColor:[UIColor textColor]];
        [applyView addSubview:lbl1];
        lbl1.numberOfLines = 0;
        self.aptitudeInfoLbl = lbl1;
        
        
        //
        self.refuseLbl = [UILabel labelWithFrame:CGRectZero
                                    textAligment:NSTextAlignmentLeft
                                 backgroundColor:[UIColor whiteColor]
                                            font:FONT(15)
                                       textColor:[UIColor textColor]];
        [applyView addSubview:self.refuseLbl ];
        self.refuseLbl.numberOfLines = 0;
        
        
        [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(applyView.mas_left).offset(20);
            make.right.equalTo(applyView.mas_right).offset(-20);
            make.top.equalTo(applyView.mas_top).offset(40);
        }];
        
        [self.refuseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbl1.mas_left);
            make.right.equalTo(lbl1.mas_right);
            make.top.equalTo(lbl1.mas_bottom).offset(50);
        }];
        
        
        //
        UIButton *replayBtn = [UIButton zhBtnWithFrame:CGRectZero title:@"重新申请"];
        [applyView addSubview:replayBtn];
        self.reApplyBtn = replayBtn;
        [replayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(applyView.mas_bottom).offset(-100);
            make.left.equalTo(applyView.mas_left).offset(20);
            make.right.equalTo(applyView.mas_right).offset(-20);
            make.height.mas_equalTo(40);
            
        }];
        [replayBtn addTarget:self action:@selector(reApplyAptitudeAction) forControlEvents:UIControlEventTouchUpInside];
        
        //
    }
    
    return _aptitudeView;

}



- (void)initData {

    self.nameLbl.text = [CDCompany company].name;
    self.aptitudeNameLbl.text = [CDCompany company].gsQualify.qualifyName;

}


- (void)addNotification {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoChange) name:kUserInfoChange object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopInfoChange) name:kUserInfoChange object:nil];
    //未读消息

}





#pragma mark- 用户信息变更的通知,处理
- (void)userInfoChange {

    TLNetworking *http = [TLNetworking new];
    http.code = USER_INFO;
    http.parameters[@"userId"] = [ZHUser user].userId;
    http.parameters[@"token"] = [ZHUser user].token;
    [http postWithSuccess:^(id responseObject) {
        
        [[ZHUser user] saveUserInfo:responseObject[@"data"] token:[ZHUser user].token userId:[ZHUser user].userId];
        [[ZHUser user] setUserInfoWithDict:responseObject[@"data"]];
        
    } failure:^(NSError *error) {
        
    }];
    
//    if ([ZHUser user].userExt.photo) {
//        
//        [self.photoBtn sd_setImageWithURL:[NSURL URLWithString:[[ZHUser user].userExt.photo convertThumbnailImageUrl]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"头像占位图"]];
//    }
    
}


#pragma mark-- 刷新
- (void)refreshState {

    //1.用户信息
    //2.店铺信息
    //3.账户信息
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.bgScrollView.mj_header endRefreshing];
        
    });
    
//    [self getAccountInfo]; //获取账户信息
    [self userInfoChange]; //用户信息变更
    

}



#pragma mark-- 设置
- (void)set {

    [self.navigationController pushViewController:[[ZHMineSetVC alloc] init] animated:YES];
    
}



#pragma mark-- 底部四个功能
- (void)funcAction:(NSInteger)index {

    switch (index) {
        case 0: {
            
            ZHShopInfoChangeVC *vc = [[ZHShopInfoChangeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }  break;
        case 1: {
            
            CDServiceMgtVC *msgVC = [[CDServiceMgtVC alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];
            
        }
            
        break;
        case 2:{
            
            CDIdeaHandleVC *vc = [[CDIdeaHandleVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
            }
            break;

        case 3: {
            
            ZHMsgVC *msgVC = [[ZHMsgVC alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];

        }

        break;
            
    }

}





- (void)introduce {

    ZHSJIntroduceVC *vc = [[ZHSJIntroduceVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setUpUI {
    
    if (self.bgScrollView) {
        return;
    }
    //
    self.bgScrollView  =  [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.bgScrollView];
    self.bgScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshState)];
    
    
    //头部
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    headerImageView.backgroundColor = [UIColor orangeColor];
    headerImageView.userInteractionEnabled = YES;
    headerImageView.image = [UIImage imageNamed:@"首页背景"];
    
    [self.bgScrollView addSubview:headerImageView];
    
    //名字
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, 30*SCREEN_SCALE, SCREEN_WIDTH, 25)
                                  textAligment:NSTextAlignmentCenter
                               backgroundColor:[UIColor clearColor]
                                          font:[UIFont systemFontOfSize:20*SCREEN_SCALE]
                                     textColor:[UIColor whiteColor]];
    [headerImageView addSubview:nameLbl];
    nameLbl.height = [[UIFont systemFontOfSize:20*SCREEN_SCALE] lineHeight];
    self.nameLbl = nameLbl;
    
    //头像
    UIButton *photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, nameLbl.yy + 12*SCREEN_SCALE, 60*SCREEN_SCALE, 60*SCREEN_SCALE)];
    photoBtn.centerX = SCREEN_WIDTH/2.0;
    photoBtn.layer.cornerRadius = photoBtn.height / 2.0;
    photoBtn.layer.borderWidth = 2;
    photoBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    photoBtn.clipsToBounds = YES;
    [headerImageView addSubview:photoBtn];
    [photoBtn addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    self.photoBtn = photoBtn;
    [photoBtn setBackgroundImage:[UIImage imageNamed:@"头像占位图"] forState:UIControlStateNormal];
    
    //
    self.aptitudeNameLbl = [UILabel labelWithFrame:CGRectMake(0, photoBtn.yy + 10, SCREEN_WIDTH, 25)
                                      textAligment:NSTextAlignmentCenter
                                   backgroundColor:[UIColor clearColor]
                                              font:[UIFont systemFontOfSize:20*SCREEN_SCALE]
                                         textColor:[UIColor whiteColor]];
    [headerImageView addSubview:self.aptitudeNameLbl];
    
    
    //入门
    UIButton *introduceBtn = [[UIButton alloc] init];
    [headerImageView addSubview:introduceBtn];
    [introduceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    introduceBtn.titleLabel.font = FONT(15);
    [introduceBtn setTitle:@"新手入门" forState:UIControlStateNormal];
    [introduceBtn addTarget:self action:@selector(introduce) forControlEvents:UIControlEventTouchUpInside];
    [introduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerImageView.mas_right).offset(-15);
        make.centerY.equalTo(self.nameLbl);
    }];
    
    //尾部
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, headerImageView.yy, SCREEN_WIDTH, SCREEN_HEIGHT - headerImageView.height)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView addSubview:footerView];
    
    //
    NSArray *funcImages = @[@"店铺管理",@"服务管理",@"意向处理",@"系统公告"];
    NSArray *funcNames = @[@"店铺管理",@"服务管理",@"意向处理",@"系统公告"];

    CGFloat funcW = 80;
    CGFloat funcH = funcW + 5 + 25;

    CGFloat leftMargin = (SCREEN_WIDTH - 2*funcW)/4.0;
//    CGFloat topMargin = (SCREEN_HEIGHT - headerImageView.height - 2*funcH)/3;
    CGFloat topMargin = 37*SCREEN_SCALE;

     __weak typeof(self) weakSelf = self;
    for (NSInteger i = 0; i < funcImages.count; i ++) {
        
        CGFloat x = leftMargin + (funcW + 2*leftMargin)*(i%2);
        CGFloat y = topMargin + (topMargin + funcH)*(i/2);
        
        ZHFuncView *funcView = [[ZHFuncView alloc] initWithFrame:CGRectMake(x, y, funcW, funcH) funcName:funcNames[i] funcImage:funcImages[i]];
        funcView.index = i;
        funcView.selected = ^(NSInteger index){
        
            [weakSelf funcAction:index];
        };
        
        if (0 == i) {
            self.kefuFuncView = funcView;
        }
        
        [footerView addSubview:funcView];
        
    }
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
