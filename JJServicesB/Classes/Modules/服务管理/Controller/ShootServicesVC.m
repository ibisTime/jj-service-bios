//
//  CDServicesInfoChangeVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "ShootServicesVC.h"
//#import "ZHGoodsDetailEditView.h"
#import "TypeChooseVC.h"
#import "TypeModel.h"


@interface ShootServicesVC ()

@property (nonatomic, strong) TLTextField *nameTf;
@property (nonatomic, strong) TLTextField *quoteMaxTf;
@property (nonatomic, strong) TLTextField *quoteMinTf;

@property (nonatomic, strong) TLTextField *pyNumTf;
@property (nonatomic, strong) TLTextField *sysNumTf;

@property (nonatomic, strong) TLTextField *isDingZhiTf;
@property (nonatomic, strong) TLTextField *scpslmTf;
@property (nonatomic, strong) TLTextField *worksTf;
@property (nonatomic, copy) NSString *isDingZhi;


@end

@implementation ShootServicesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self tl_placeholderOperation];
            [self setUpUI];
            [self initData];
    
}



//- (void)tl_placeholderOperation {
//    
//    [self setPlaceholderViewTitle:@"加载失败" operationTitle:@"重新加载"];
//    TLNetworking *http = [TLNetworking new];
//    http.showView = self.view;
//    http.code = @"612141";
//    http.parameters[@"code"] = self.servicesBaseModel.code;
//    [http postWithSuccess:^(id responseObject) {
//        
//        [self removePlaceholderView];
//        [self setUpUI];
//        [self initData];
//        
//    } failure:^(NSError *error) {
//        
//        [self addPlaceholderView];
//        
//        
//    }];
//    
//}

//
- (void)initData {
    
    
    if (self.shootModel) {
       
        self.nameTf.text = self.shootModel.name;
        self.quoteMaxTf.text = [NSString stringWithFormat:@"%@",self.shootModel.quoteMax];
        self.quoteMinTf.text = [NSString stringWithFormat:@"%@",self.shootModel.quoteMin];
        
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[self.shootModel.pic convertThumbnailImageUrl]]];
        self.detailEditView.images =  self.shootModel.detailPics.mutableCopy;
        self.detailEditView.detailTextView.text = self.shootModel.desc;
        
        self.pyNumTf.text = [self.shootModel.pyNum stringValue];
        self.sysNumTf.text = [self.shootModel.sysNum stringValue];
        self.scpslmTf.text = self.shootModel.scpslm;
        self.worksTf.text = self.shootModel.works;

        self.isDingZhi = self.shootModel.isDz;
        if ([self.shootModel.status isEqualToString:@"1"]) {
            
            self.isDingZhiTf.text=  @"是";
            
        } else {
            
            self.isDingZhiTf.text=  @"否";

        }

    }

    
    //

    
    //
    
}


- (void)chooseType {

    TypeModel *model = [TypeModel new];
    model.key = @"是";
    model.value = @"1";
    
    TypeModel *noModel = [TypeModel new];
    noModel.key = @"否";
    noModel.value = @"0";
    
    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
    vc.typeArrays = @[model,noModel];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setSelected:^(TypeModel *model){
        
        [self.navigationController popViewControllerAnimated:YES];
        self.isDingZhiTf.text = model.key;
        self.isDingZhi = model.value;
        
    }];
    
    
}

//
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
    self.pyNumTf = [self tfWithFrame:CGRectMake(0, self.quoteMaxTf.yy, SCREEN_WIDTH, 45) leftTitle:@"棚影数量" placeholder:@"请输入"];
    [bgSV addSubview:self.pyNumTf];
    self.pyNumTf.keyboardType = UIKeyboardTypeNumberPad;
    
    
    //
    self.sysNumTf = [self tfWithFrame:CGRectMake(0, self.pyNumTf.yy, SCREEN_WIDTH, 45) leftTitle:@"摄影师数量" placeholder:@"请输入"];
    [bgSV addSubview:self.sysNumTf];
    self.sysNumTf.keyboardType = UIKeyboardTypeNumberPad;

    
    self.scpslmTf = [self tfWithFrame:CGRectMake(0, self.sysNumTf.yy, SCREEN_WIDTH, 45) leftTitle:@"栏目" placeholder:@"请输入"];
    [bgSV addSubview:self.scpslmTf];
    
    //
    self.worksTf = [self tfWithFrame:CGRectMake(0, self.scpslmTf.yy, SCREEN_WIDTH, 45) leftTitle:@"作品" placeholder:@"请输入"];
    [bgSV addSubview:self.worksTf];
    
    //
    self.isDingZhiTf = [self tfWithFrame:CGRectMake(0, self.worksTf.yy, SCREEN_WIDTH, 45) leftTitle:@"是否定制" placeholder:@"请选择"];
    [bgSV addSubview:self.isDingZhiTf];
    self.isDingZhiTf.enabled = NO;
    
    UIControl *maskCtrl = [[UIControl alloc] initWithFrame:self.isDingZhiTf.frame];
    [bgSV addSubview:maskCtrl];
    [maskCtrl addTarget:self action:@selector(chooseType) forControlEvents:UIControlEventTouchUpInside];
    
    
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

#pragma mark- 保存操作
- (void)saveService {
    
    [self saveWithCoverImg:self.shootModel ? self.shootModel.pic : nil];
    
}


- (BOOL)valitInput {
    
//    [super valitInput];
    if ([self.coverImageView.image isEqual:[UIImage imageNamed:@"商铺"]]) {
        [TLAlert alertWithInfo:@"请选择缩略图"];
        return NO;
    }
    
    if (self.detailEditView.images.count <= 0) {
        
        [TLAlert alertWithInfo:@"请选详情图片"];
        
        return NO;
    }
    
    //不需要验证图片
    if (![self.nameTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入名称"];
        return NO;
    }
    //
    if (![self.quoteMinTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入最小报价"];
        return NO;
    }
    if (![self.quoteMaxTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入最大报价"];
        return NO;
    }
    
    if (![self.pyNumTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入棚影数量"];
        return NO;
    }
    
    if (![self.sysNumTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入摄影师数量"];
        return NO;
    }
    
    //
    if (![self.scpslmTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入栏目"];
        return NO;
    }
    
    if (![self.worksTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入作品"];
        return NO;
    }
    
    if (!self.isDingZhi) {
        
        [TLAlert alertWithInfo:@"选择是否定制"];
        return NO;
    }
   
    
    return YES;
}


- (void)upLoadImageSuccessCoverImgKey:(NSString *)coverImageKey detailImageKeys:(NSString *)keys {
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    if (self.shootModel) {
        
        http.code = @"612082";
        http.parameters[@"code"] = self.shootModel.code;

    } else {
    
        http.code = @"612080";

    }
    http.parameters[@"name"] = self.nameTf.text;
    http.parameters[@"pic"] = coverImageKey;
    http.parameters[@"advPic"] = keys;
    http.parameters[@"companyCode"] = [CDCompany company].code;
    http.parameters[@"quoteMin"] = self.quoteMinTf.text;
    http.parameters[@"quoteMax"] = self.quoteMaxTf.text;
    http.parameters[@"qualityCode"] = [CDCompany company].gsQualify.code;
    http.parameters[@"works"] = self.worksTf.text;
    http.parameters[@"description"] = self.detailEditView.detailTextView.text;
    http.parameters[@"publisher"] = [ZHUser user].userId;
    
    //
    http.parameters[@"pyNum"] = self.pyNumTf.text;
    http.parameters[@"isDz"] = self.isDingZhi;
    http.parameters[@"sysNum"] = self.sysNumTf.text;
    http.parameters[@"scpslm"] = self.scpslmTf.text;
    
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
