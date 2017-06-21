//
//  CDShopAptitudesApplyVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/15.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDShopAptitudesApplyVC.h"
#import "TLPickerTextField.h"
#import "TLPickerView.h"
#import "CDCompanyAptitudeModel.h"

@interface CDShopAptitudesApplyVC ()

//个体名称
@property (nonatomic, strong) TLTextField *nameTf;
@property (nonatomic, strong) TLTextField *aptitudeChooseTf;//资质选择

@property (nonatomic, strong) TLTextField *aptitudeIn;

@property (nonatomic, strong) TLTextField *sloganTf;

@property (nonatomic, strong) TLTextField *zoneTf;

@property (nonatomic, copy) NSArray <CDCompanyAptitudeModel *>*aptitudeModles;
@property (nonatomic, strong) CDCompanyAptitudeModel *currentAptitudeModel;

@property (nonatomic, strong) UILabel *descLbl;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *contentV;

@property (nonatomic, strong) UIScrollView *bgSV;

@end

@implementation CDShopAptitudesApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPlaceholderViewTitle:@"加载失败" operationTitle:@"重新加载"];
    
    [self tl_placeholderOperation];
    
 
}

- (void)tl_placeholderOperation {

    [TLProgressHUD showWithStatus:nil];
    [[CDCompany company] getAptitudeModelsSuccess:^{
        
        [self removePlaceholderView];
        [TLProgressHUD dismiss];
        self.aptitudeModles = [CDCompany company].aptitudeModles;
        
        
        [self setUpUI];
        [self initData];
        
    } failure:^{
        
        [TLProgressHUD dismiss];
        [self addPlaceholderView];

    }];
    
    
    //查资质
//    TLNetworking *http = [TLNetworking new];
//    http.showView = self.view;
//    http.code = @"612016";
//    //0 待审核 1 审核通过 2 审核不通过
//    http.parameters[@"status"] = @"1";
//    [http postWithSuccess:^(id responseObject) {
//        
//      
//        [self removePlaceholderView];
//        
//        self.aptitudeModles = [CDCompanyAptitudeModel tl_objectArrayWithDictionaryArray:responseObject[@"data"]];
//        
//        
//        [self setUpUI];
//        [self initData];
//        
//    } failure:^(NSError *error) {
//        
//        [self addPlaceholderView];
//
//        
//    }];

}

//
- (void)initData {

    self.nameTf.text = [CDCompany company].name;
    self.title = @"申请资质";

    if ([CDCompany company].gsQualify.code) {
        
        self.title = @"重新申请";
        self.aptitudeChooseTf.text = [CDCompany company].gsQualify.qualifyName;
        self.sloganTf.text = [CDCompany company].gsQualify.slogan;
//        self.zoneTf.text =  @"---";
        
        [self.aptitudeModles enumerateObjectsUsingBlock:^(CDCompanyAptitudeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.code isEqualToString:[CDCompany company].gsQualify.qualifyCode]) {
                
                self.currentAptitudeModel = obj;

            }
            
        }];

        
    }

}

- (void)chooseAptitude {
    
    NSMutableArray <NSString *>*arr = [[NSMutableArray alloc] initWithCapacity:self.aptitudeModles.count];
    [self.aptitudeModles enumerateObjectsUsingBlock:^(CDCompanyAptitudeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [arr addObject:obj.name];
        
    }];
    //
    TLPickerView *picker = [TLPickerView pickerView];
    picker.tagNames = arr;
    [picker show];
    

    [picker setDidSelect:^(NSInteger idx){
        
        self.currentAptitudeModel = self.aptitudeModles[idx];
        self.aptitudeChooseTf.text = self.currentAptitudeModel.name;
        
        if (self.contentV) {
            [self.contentV removeFromSuperview];
        }
        
        self.contentV = [self content:self.currentAptitudeModel.desc];
        [self.bgSV addSubview:self.contentV];
        
        self.contentV.y = self.aptitudeChooseTf.yy;
        self.sloganTf.y = self.contentV.yy + 10;
        self.zoneTf.y = self.sloganTf.yy;
        
        self.confirmBtn.y = self.zoneTf.yy  + 60;
        
    }];
    
    
}


- (UIView *)content:(NSString *)content {

        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        bgView.backgroundColor = [UIColor whiteColor];
    self.contentV = bgView;
    
        UILabel *lbl = [UILabel labelWithFrame:CGRectZero
                                  textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor whiteColor]
                                          font:FONT(15)
                                     textColor:[UIColor textColor]];
        [bgView addSubview:lbl];
        lbl.text = @"资质简介";
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bgView.mas_left).offset(15);
        make.centerY.equalTo(bgView.mas_centerY);
        
    }];
    
    
     UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(100, 15, SCREEN_WIDTH - 100 - 15, 45)
                                  textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor whiteColor]
                                          font:FONT(15)
                                     textColor:[UIColor textColor]];
        [bgView addSubview:contentLbl];
        contentLbl.numberOfLines = 0;
    
       contentLbl.text = content;
       CGSize size  = [contentLbl sizeThatFits:CGSizeMake(contentLbl.width, MAXFLOAT)];
    contentLbl.height = size.height;
    bgView.height = size.height + 30;
        return bgView;
    
}


- (void)confirm {
    
    if (!self.currentAptitudeModel) {
        [TLAlert alertWithInfo:@"请选择店铺资质"];
        return;
    }
    
    if (![self.sloganTf.text valid]) {
        [TLAlert alertWithInfo:@"请输入广告语"];
        return;
    }
    
    if (![self.zoneTf.text valid]) {
        [TLAlert alertWithInfo:@"请输入报价区间"];
        return;
    }
    

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    if ([CDCompany company].gsQualify.code) {
        //重新申请
        http.code = @"612072";
        http.parameters[@"code"] = [CDCompany company].gsQualify.code;

    } else {
        
        http.code = @"612070";
        
    }
    
    //
    http.parameters[@"companyCode"] = [CDCompany company].code;
    //资质编号
    http.parameters[@"qualifyCode"] = self.currentAptitudeModel.code;
    http.parameters[@"slogan"] = self.sloganTf.text;
    http.parameters[@"priceRange"] = self.zoneTf.text;
    http.parameters[@"applyUser"] = [ZHUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        
        if (![CDCompany company].gsQualify.code) {
            
            [CDCompany company].gsQualify = [[CDCompanyAptitudeModel alloc] init];

        }
        
        if (self.success) {
            
            self.success();
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)setUpUI {

    UIScrollView *bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:bgSV];
    self.bgSV = bgSV;
    
    //
    CGFloat h = 45;
    self.nameTf = [self tfWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 45) leftTitle:@"个体名称"];
    [bgSV addSubview:self.nameTf];
    
    //
    self.aptitudeChooseTf = [self tfWithFrame:CGRectMake(0, self.nameTf.yy, SCREEN_WIDTH, h) leftTitle:@"资质名称"];
    [bgSV addSubview:self.aptitudeChooseTf];
    self.aptitudeChooseTf.enabled = NO;
    self.aptitudeChooseTf.placeholder = @"请选择资质";
    
    //
    UIControl *maskCtrl = [[UIControl alloc] initWithFrame:self.aptitudeChooseTf.frame];
    [bgSV addSubview:maskCtrl];
    [maskCtrl addTarget:self action:@selector(chooseAptitude) forControlEvents:UIControlEventTouchUpInside];
    
    //资质简介

    
    
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.left.equalTo(bgSV.mas_left);
//        make.top.equalTo(self.aptitudeChooseTf.mas_bottom);
////        make.bottom.equalTo(contentLbl.mas_bottom);
//        
//    }];
//    
//    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(bgView.mas_left).offset(15);
//        make.centerY.equalTo(bgView.mas_centerY);
//        
//    }];
//    
//    [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(bgView.mas_left).offset(100);
//        make.top.equalTo(bgView.mas_top).offset(10);
//        make.right.equalTo(bgView.mas_right).offset(-15);
//        
//    }];
    
    
    //
    self.sloganTf = [self tfWithFrame:CGRectMake(0, self.aptitudeChooseTf.yy + 10, SCREEN_WIDTH, h) leftTitle:@"广告语"];
    [bgSV addSubview:self.sloganTf];
    self.sloganTf.placeholder = @"请输入广告语";

    
    //
    self.zoneTf = [self tfWithFrame:CGRectMake(0, self.sloganTf.yy, SCREEN_WIDTH, h) leftTitle:@"报价区间"];
    [bgSV addSubview:self.zoneTf];
    self.zoneTf.placeholder = @"请输入报价区间";
    
//    [self.zoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(bgSV.mas_left);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(h);
//        
//        make.top.equalTo(self.sloganTf.mas_bottom);
//        
//    }];
    
    //
    UIButton *confirmBtn = [UIButton zhBtnWithFrame:CGRectMake(30,self.zoneTf.yy +  60,SCREEN_WIDTH - 60, 45) title:@"确定"];
    [bgSV addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    self.confirmBtn = confirmBtn;
//    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(bgSV.mas_left).offset(30);
//        make.width.mas_equalTo(SCREEN_WIDTH - 60);
//        make.height.mas_equalTo(45);
//    
//        make.top.equalTo(self.zoneTf.mas_bottom).offset(60);
//        
//    }];
    
}




- (TLTextField *)tfWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle  {

    TLTextField *tf = [[TLTextField alloc] initWithframe:frame leftTitle:leftTitle titleWidth:100 placeholder:nil];

    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lineColor];
    [tf addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tf.mas_left);
        make.width.equalTo(tf.mas_width);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(tf.mas_bottom);
    }];
    return tf;

}




@end
