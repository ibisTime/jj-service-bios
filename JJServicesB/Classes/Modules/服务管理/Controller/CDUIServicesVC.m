//
//  CDServicesInfoChangeVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDUIServicesVC.h"
#import "ZHGoodsDetailEditView.h"


@interface CDUIServicesVC ()


@property (nonatomic, strong) TLTextField *nameTf;


@property (nonatomic, strong) TLTextField *quoteMaxTf;
@property (nonatomic, strong) TLTextField *quoteMinTf;

@property (nonatomic, strong) TLTextField *designNumTf;
@property (nonatomic, strong) TLTextField *sclmTf;

@property (nonatomic, strong) TLTextField *homeDaysTf;
@property (nonatomic, strong) TLTextField *homePriceTf;

//
@property (nonatomic, strong) TLTextField *detailDaysTf;
@property (nonatomic, strong) TLTextField *detailPriceTf;

//
@property (nonatomic, strong) TLTextField *bannerDaysTf;
@property (nonatomic, strong) TLTextField *bannerPriceTf;

//
@property (nonatomic, strong) TLTextField *allDaysTf;
@property (nonatomic, strong) TLTextField *allPriceTf;
@property (nonatomic, strong) TLTextField *worksTf;



@end

@implementation CDUIServicesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self tl_placeholderOperation];
    
}



- (void)tl_placeholderOperation {

    [self setPlaceholderViewTitle:@"加载失败" operationTitle:@"重新加载"];
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"612141";
    http.parameters[@"code"] = self.servicesBaseModel.code;
    [http postWithSuccess:^(id responseObject) {
        
        [self removePlaceholderView];
        [self setUpUI];
        [self initData];
        
    } failure:^(NSError *error) {
        
        [self addPlaceholderView];
        
        
    }];

}

//
- (void)initData {

    self.nameTf.text = @"xxx";
    self.quoteMaxTf.text = @"100";
    self.quoteMinTf.text = @"1";
    
    //
    self.designNumTf.text = @"10";
    self.sclmTf.text = @"m擅长";
    self.homeDaysTf.text = @"10";
    self.homePriceTf.text = @"10";

    self.bannerDaysTf.text = @"10";
    self.bannerPriceTf.text = @"10";
    
    self.allPriceTf.text = @"10";
    self.allDaysTf.text = @"10";
    
    self.detailDaysTf.text = @"10";
    self.detailPriceTf.text = @"10";
    
    //
    self.worksTf.text = @"www.eddd.com";
    self.detailEditView.detailTextView.text = @"详情";

}

- (void)setUpUI {
    
    UIScrollView *bgSV = self.bgSV;
    
    
    
    //
    self.nameTf = [self tfWithFrame:CGRectMake(0, self.headerView.yy + 10, SCREEN_WIDTH, 45) leftTitle:@"名称" placeholder:@"请输入名称"];
    [bgSV addSubview:self.nameTf];
    
    //
    self.quoteMinTf = [self tfWithFrame:CGRectMake(0, self.nameTf.yy, SCREEN_WIDTH, 45) leftTitle:@"最小报价" placeholder:@"请输入"];
    [bgSV addSubview:self.quoteMinTf];
    self.quoteMinTf.keyboardType = UIKeyboardTypeDecimalPad;
    
    //
    self.quoteMaxTf = [self tfWithFrame:CGRectMake(0, self.quoteMinTf.yy, SCREEN_WIDTH, 45) leftTitle:@"最大报价" placeholder:@"请输入"];
    [bgSV addSubview:self.quoteMaxTf];
    self.quoteMaxTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    //
    self.designNumTf = [self tfWithFrame:CGRectMake(0, self.quoteMaxTf.yy, SCREEN_WIDTH, 45) leftTitle:@"设计师人数" placeholder:@"请输入"];
    [bgSV addSubview:self.designNumTf];
    self.designNumTf.keyboardType = UIKeyboardTypeNumberPad;

    
    //
    self.sclmTf = [self tfWithFrame:CGRectMake(0, self.designNumTf.yy, SCREEN_WIDTH, 45) leftTitle:@"擅长类目" placeholder:@"请输入"];
    [bgSV addSubview:self.sclmTf];
    
    //
    self.homeDaysTf = [self tfWithFrame:CGRectMake(0, self.sclmTf.yy, SCREEN_WIDTH, 45) leftTitle:@"首页天数" placeholder:@"请输入"];
    [bgSV addSubview:self.homeDaysTf];
    self.homeDaysTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    self.homePriceTf = [self tfWithFrame:CGRectMake(0, self.homeDaysTf.yy, SCREEN_WIDTH, 45) leftTitle:@"首页价格" placeholder:@"请输入"];
    [bgSV addSubview:self.homePriceTf];
    self.homePriceTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    //详情
    self.detailDaysTf = [self tfWithFrame:CGRectMake(0, self.homePriceTf.yy, SCREEN_WIDTH, 45) leftTitle:@"详情天数" placeholder:@"请输入"];
    [bgSV addSubview:self.detailDaysTf];
    self.detailDaysTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    self.detailPriceTf = [self tfWithFrame:CGRectMake(0, self.detailDaysTf.yy, SCREEN_WIDTH, 45) leftTitle:@"详情价格" placeholder:@"请输入"];
    [bgSV addSubview:self.detailPriceTf];
    self.detailPriceTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    //
    self.bannerDaysTf = [self tfWithFrame:CGRectMake(0, self.detailPriceTf.yy, SCREEN_WIDTH, 45) leftTitle:@"海报天数" placeholder:@"请输入"];
    [bgSV addSubview:self.bannerDaysTf];
    self.bannerDaysTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    self.bannerPriceTf = [self tfWithFrame:CGRectMake(0, self.bannerDaysTf.yy, SCREEN_WIDTH, 45) leftTitle:@"海报价格" placeholder:@"请输入"];
    [bgSV addSubview:self.bannerPriceTf];
    self.bannerPriceTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    //
    self.allDaysTf = [self tfWithFrame:CGRectMake(0, self.bannerPriceTf.yy, SCREEN_WIDTH, 45) leftTitle:@"全店天数" placeholder:@"请输入"];
    [bgSV addSubview:self.allDaysTf];
    self.allDaysTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    //
    self.allPriceTf = [self tfWithFrame:CGRectMake(0, self.allDaysTf.yy, SCREEN_WIDTH, 45) leftTitle:@"全店价格" placeholder:@"请输入"];
    [bgSV addSubview:self.allPriceTf];
    self.allPriceTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    //
    self.worksTf = [self tfWithFrame:CGRectMake(0, self.bannerPriceTf.yy, SCREEN_WIDTH, 45) leftTitle:@"作品" placeholder:@"请输入"];
    [bgSV addSubview:self.worksTf];
   
    //简介
    //    self.detailEditView = [[ZHGoodsDetailEditView alloc] initWithFrame:CGRectMake(0, self.self.priceTf.yy, SCREEN_WIDTH, 200)];
    //    self.detailEditView.placholder = @"请输入一些描述信息";
    //    self.detailEditView.typeNameLbl.text = @"描述";
    //    [bgSV addSubview:self.detailEditView];
    
    self.detailEditView.y = self.worksTf.yy + 10;
    
    //
    UIButton *confirmBtn = [UIButton zhBtnWithFrame:CGRectMake(20, self.detailEditView.yy + 30, SCREEN_WIDTH - 40, 45) title:@"确认"];
    [bgSV addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(saveService) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *hintLbl = [UILabel labelWithFrame:CGRectMake(20, confirmBtn.yy + 10, confirmBtn.width, 20) textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor clearColor]
                                          font:FONT(14)
                                     textColor:[UIColor textColor]];
    
    [bgSV addSubview:hintLbl];
    hintLbl.text = @"点击确认后将会有工作人员与您联系";
    
    bgSV.contentSize = CGSizeMake(SCREEN_WIDTH, hintLbl.yy  +10);
    
}

- (void)saveService {

    [self saveWithCoverImg:nil];

}


//- (BOOL)valitInput {
//    
//    [super valitInput];
//    
//    
//    return YES;
//}


- (void)upLoadImageSuccessCoverImgKey:(NSString *)coverImageKey detailImageKeys:(NSString *)keys {
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"612120";
    http.parameters[@"name"] = self.nameTf.text;
    http.parameters[@"pic"] = coverImageKey;
    http.parameters[@"advPic"] = keys;
    
    http.parameters[@"companyCode"] = [CDCompany company].code;
    http.parameters[@"quoteMin"] = self.quoteMinTf.text;
    http.parameters[@"quoteMax"] = self.quoteMaxTf.text;
    http.parameters[@"qualityCode"] = [CDCompany company].gsQualify.code;

    
    http.parameters[@"designNum"] = self.designNumTf.text;
    http.parameters[@"sclm"] = self.sclmTf.text;
    
    http.parameters[@"homeDays"] = self.homeDaysTf.text;
    http.parameters[@"homePrice"] = self.homePriceTf.text;
    
    http.parameters[@"detailDays"] = self.detailDaysTf.text;
    http.parameters[@"detailPrice"] = self.detailPriceTf.text;
    
    http.parameters[@"bannerDays"] = self.bannerDaysTf.text;
    http.parameters[@"bannerPrice"] = self.bannerPriceTf.text;
    
    http.parameters[@"allDays"] = self.allDaysTf.text;
    http.parameters[@"allPrice"] = self.allPriceTf.text;
    
    http.parameters[@"works"] = self.worksTf.text;
    
    http.parameters[@"description"] = self.detailEditView.detailTextView.text;
    http.parameters[@"publisher"] = [ZHUser user].userId;
    
    
//    http.parameters[@"tgfw"] = @"D";
  
    [http postWithSuccess:^(id responseObject) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
        
    }];

    
    

}

- (TLTextField *)tfWithFrame:(CGRect)frame leftTitle:(NSString *)title placeholder:(NSString *)placeholder {
    
    TLTextField *tf = [[TLTextField alloc] initWithframe:frame leftTitle:title titleWidth:110 placeholder:placeholder];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lineColor];
    [tf addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tf);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(tf.mas_bottom);
    }];
    return tf;
    
}


//- (UIView *)setUpTableViewHeaderView {
//
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
//    headerView.backgroundColor = [UIColor whiteColor];
//    //图片选择手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImg)];
//    [headerView addGestureRecognizer:tap];
//
//    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 5, 100, 25) textAligment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] font:[UIFont secondFont] textColor:[UIColor zh_textColor]];
//    [headerView addSubview:nameLbl];
//    nameLbl.centerY = headerView.height/2.0;
//    nameLbl.text = @"公司封面";
//    //    self.coverHintLbl = nameLbl;
//
//    //
//    UIImageView *shopCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 60)];
//    shopCoverImageView.image = [UIImage imageNamed:@"商铺"];
//    shopCoverImageView.xx_size = SCREEN_WIDTH - 20;
//    shopCoverImageView.clipsToBounds = YES;
//    shopCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
//    shopCoverImageView.centerY = headerView.height/2.0;
//    [headerView addSubview:shopCoverImageView];
//    self.coverImageView = shopCoverImageView;
//
//
//    return headerView;
//    
//}

@end
