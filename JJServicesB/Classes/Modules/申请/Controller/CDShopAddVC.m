//
//  CDShopAddVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/15.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDShopAddVC.h"
#import "ZHFuncView.h"
#import "CDShopRegisterVC.h"

//#import "CDShopAptitudesApplyVC.h"

@interface CDShopAddVC ()

@end

@implementation CDShopAddVC


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor themeColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor themeColor] convertToImage] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIColor themeColor] convertToImage];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家入驻";
    
    //
    UIScrollView *bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:bgSV];
    bgSV.backgroundColor = [UIColor whiteColor];
    
    UIView *scrollContnetView = [[UIView alloc] init];
    scrollContnetView.backgroundColor = [UIColor whiteColor];
    [bgSV addSubview:scrollContnetView];
    
    [scrollContnetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(bgSV);
        make.width.equalTo(bgSV.mas_width);
    }];
    
    //
    UILabel *Lbl1 = [UILabel labelWithFrame:CGRectZero
                               textAligment:NSTextAlignmentCenter
                            backgroundColor:[UIColor whiteColor]
                                       font:FONT(16)
                                  textColor:[UIColor textColor]];
    [scrollContnetView addSubview:Lbl1];
    
    //
    UILabel *Lbl2 = [UILabel labelWithFrame:CGRectZero
                               textAligment:NSTextAlignmentCenter
                            backgroundColor:[UIColor whiteColor]
                                       font:FONT(16)
                                  textColor:[UIColor textColor]];
    [scrollContnetView addSubview:Lbl2];
    
    //
    UILabel *Lbl3 = [UILabel labelWithFrame:CGRectZero
                               textAligment:NSTextAlignmentCenter
                            backgroundColor:[UIColor whiteColor]
                                       font:FONT(16)
                                  textColor:[UIColor textColor]];
    [scrollContnetView addSubview:Lbl3];
    
    [Lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollContnetView.mas_top).offset(32);
        make.centerX.equalTo(scrollContnetView.mas_centerX);
    }];
    
    [Lbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Lbl1.mas_bottom).offset(20);
        make.centerX.equalTo(scrollContnetView.mas_centerX);
    }];
    
    [Lbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Lbl2.mas_bottom).offset(20);
        make.centerX.equalTo(scrollContnetView.mas_centerX);
    }];
    
    
    //选择按钮
    
    //
    Lbl1.text = @"商家入驻";
    Lbl2.text = @"全国500+商户老板已成功入驻";
    Lbl3.text = @"为20万用户服务";
    
    
   //
    CGFloat funcY = 200 + 72;
    CGFloat margin = (SCREEN_WIDTH - 88*2)/6.0;
    
    ZHFuncView *individualFunc = [[ZHFuncView alloc] initWithFrame:CGRectMake(0, funcY, 88, 120) funcName:@"个体户" funcImage:@"个体户"];
    [scrollContnetView addSubview:individualFunc];
    individualFunc.nameLbl.font = FONT(17);
    
    //
    ZHFuncView *enterpriseFunc = [[ZHFuncView alloc] initWithFrame:CGRectMake(individualFunc.xx, funcY, 88, 120) funcName:@"企业" funcImage:@"企业"];
    [scrollContnetView addSubview:enterpriseFunc];
    enterpriseFunc.nameLbl.font = FONT(17);

    
    [individualFunc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Lbl3.mas_bottom).offset(72);
        make.width.equalTo(@88);
        make.height.equalTo(@140);
        make.right.equalTo(scrollContnetView.mas_centerX).offset(-margin);
    }];
    
    [enterpriseFunc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(individualFunc.mas_top);
        make.width.equalTo(individualFunc.mas_width);
        make.height.equalTo(individualFunc.mas_height);
        make.left.equalTo(scrollContnetView.mas_centerX).offset(margin);
    }];
    
    
    __weak typeof(self) weakSelf = self;
    [individualFunc setSelected:^(NSInteger idx){
        
        [weakSelf individualApply];
        
    }];
    
    [enterpriseFunc setSelected:^(NSInteger idx){
        
        [weakSelf enterpriseFuncApply];
        
    }];
    
    //3.提醒
    UIImageView *hintImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"注意"]];
    [scrollContnetView addSubview:hintImageView];
  
    
    UILabel *hintLbl = [UILabel labelWithFrame:CGRectZero
                               textAligment:NSTextAlignmentLeft
                            backgroundColor:[UIColor whiteColor]
                                       font:FONT(14)
                                  textColor:[UIColor textColor]];
    [scrollContnetView addSubview:hintLbl];
    hintLbl.numberOfLines = 0;
    hintLbl.text = @"务必是商家实际负责人的手机号注册，并进行申请资质；非本人操作可能导致法律风险；请谨慎操作!";
    
    [hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(individualFunc.mas_bottom).offset(60);
        make.left.equalTo(scrollContnetView.mas_left).offset(30);
        
    }];
    
    [hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintImageView.mas_top);
        make.left.equalTo(hintImageView.mas_right).offset(5);
        make.right.equalTo(scrollContnetView.mas_right).offset(-30);
        make.bottom.equalTo(scrollContnetView.mas_bottom);
    }];

    
}

#pragma mark- 个人
- (void)individualApply {

    CDShopRegisterVC *vc = [[CDShopRegisterVC alloc] init];
    vc.type = RegisterTypePersonal;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark- 企业
- (void)enterpriseFuncApply {
    
    CDShopRegisterVC *vc = [[CDShopRegisterVC alloc] init];
    vc.type = RegisterTypeEnterprise;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
