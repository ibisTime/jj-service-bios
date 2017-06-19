//
//  CDServicesInfoChangeVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "OperationServicesVC.h"
//#import "ZHGoodsDetailEditView.h"
#import "TypeChooseVC.h"
#import "TypeModel.h"


@interface OperationServicesVC ()

@property (nonatomic, strong) TLTextField *nameTf;
@property (nonatomic, strong) TLTextField *quoteMaxTf;
@property (nonatomic, strong) TLTextField *quoteMinTf;


@property (nonatomic, strong) TLTextField *tgfwTf; //提供服务
@property (nonatomic, strong) TLTextField *feeModeTf; //收费模式
@property (nonatomic, strong) TLTextField *payCycleTf; //付款周期

@property (nonatomic, strong) TLTextField *scyylmTf;//擅长类目
@property (nonatomic, strong) TLTextField *sucCaseTf;//成功案例

@end

@implementation OperationServicesVC

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
    
    
//    if (self.shootModel) {
//        
//        self.nameTf.text = self.shootModel.name;
//        self.quoteMaxTf.text = [NSString stringWithFormat:@"%@",self.shootModel.quoteMax];
//        self.quoteMinTf.text = [NSString stringWithFormat:@"%@",self.shootModel.quoteMin];
//        
//        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[self.shootModel.pic convertThumbnailImageUrl]]];
//        self.detailEditView.images =  self.shootModel.detailPics.mutableCopy;
//        self.detailEditView.detailTextView.text = self.shootModel.desc;
//        
//        self.pyNumTf.text = [self.shootModel.pyNum stringValue];
//        self.sysNumTf.text = [self.shootModel.sysNum stringValue];
//        self.scpslmTf.text = self.shootModel.scpslm;
//        self.worksTf.text = self.shootModel.works;
//        
//        self.isDingZhi = self.shootModel.isDz;
//     
//        
//    }
    
    
    //
    
    
    //
    
}


//- (void)chooseType {
//    
//    TypeModel *model = [TypeModel new];
//    model.key = @"是";
//    model.value = @"1";
//    
//    TypeModel *noModel = [TypeModel new];
//    noModel.key = @"否";
//    noModel.value = @"0";
//    
//    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
//    vc.typeArrays = @[model,noModel];
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc setSelected:^(TypeModel *model){
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        self.isDingZhiTf.text = model.key;
//        self.isDingZhi = model.value;
//        
//    }];
//    
//    
//}

#pragma mark- 提供服务
- (void)tgfwTypeChoose {

    
    
    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
    
    //
//    A 运营 B 推广 C 拍摄 D 美工 E 客服 F 仓储 G 打包发货
    NSDictionary *dict = @{
                           @"A" : @"运营",
                           @"B" : @"推广",
                           @"C" : @"拍摄",
                           @"D" : @"美工",
                           @"E" : @"客服",
                           @"F" : @"仓储",
                           @"G" : @"打包发货"

                           };
    
    NSMutableArray *arrs = [[NSMutableArray alloc] init];
    
    [dict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     
        TypeModel *AModel = [TypeModel new];
        AModel.value = obj;
        AModel.key = dict[obj];
        
        [arrs addObject:AModel];
        
    }];
    
    vc.typeArrays = arrs;

        [self.navigationController pushViewController:vc animated:YES];
        [vc setSelected:^(TypeModel *model){
    
        [self.navigationController popViewControllerAnimated:YES];
         self.tgfwTf.text = model.key;
            
        }];
    //
    

}

#pragma mark- 收费模式
- (void)sfmsTypeChoose {

    
    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
    
    //
//    1 基础服务费+提成 2 服务费 3 提成
    NSDictionary *dict = @{
                           @"1" : @"基础服务费+提成",
                           @"2" : @"服务费",
                           @"3" : @"提成"
                           
                           };
    
    NSMutableArray *arrs = [[NSMutableArray alloc] init];
    
    [dict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TypeModel *AModel = [TypeModel new];
        AModel.value = obj;
        AModel.key = dict[obj];
        
        [arrs addObject:AModel];
        
    }];
    
    vc.typeArrays = arrs;
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc setSelected:^(TypeModel *model){
        
        [self.navigationController popViewControllerAnimated:YES];
        self.feeModeTf.text = model.key;
        
    }];
    

}


#pragma mark- 收费选择
- (void)payCycleTypeChoose {

    
    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
//    1 月付 2 季付 3 半年付 4 年付
    NSDictionary *dict = @{
                           @"1" : @"月付",
                           @"2" : @"季付",
                           @"3" : @"半年付",
                           @"4" : @"年付"
                           };
    
    NSMutableArray *arrs = [[NSMutableArray alloc] init];
    
    [dict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TypeModel *AModel = [TypeModel new];
        AModel.value = obj;
        AModel.key = dict[obj];
        
        [arrs addObject:AModel];
        
    }];
    
    vc.typeArrays = arrs;
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc setSelected:^(TypeModel *model){
        
        [self.navigationController popViewControllerAnimated:YES];
        self.payCycleTf.text = model.key;
        
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
    self.tgfwTf = [self tfWithFrame:CGRectMake(0, self.quoteMaxTf.yy, SCREEN_WIDTH, 45) leftTitle:@"服务类型" placeholder:@"请选择"];
    [bgSV addSubview:self.tgfwTf];
    self.tgfwTf.userInteractionEnabled = NO;
    UIControl *tgfwMaskCtrl = [[UIControl alloc] initWithFrame:self.tgfwTf.frame];
    [bgSV addSubview:tgfwMaskCtrl];
    [tgfwMaskCtrl addTarget:self action:@selector(tgfwTypeChoose) forControlEvents:UIControlEventTouchUpInside];
    
    
    //
    self.feeModeTf = [self tfWithFrame:CGRectMake(0, self.tgfwTf.yy, SCREEN_WIDTH, 45) leftTitle:@"收费模式" placeholder:@"请选择"];
    [bgSV addSubview:self.feeModeTf];
    self.feeModeTf.userInteractionEnabled = NO;
    
    UIControl *sfmsMaskCtrl = [[UIControl alloc] initWithFrame:self.feeModeTf.frame];
    [bgSV addSubview:sfmsMaskCtrl];
    [sfmsMaskCtrl addTarget:self action:@selector(sfmsTypeChoose) forControlEvents:UIControlEventTouchUpInside];
    //
    
    
    self.payCycleTf = [self tfWithFrame:CGRectMake(0, self.feeModeTf.yy, SCREEN_WIDTH, 45) leftTitle:@"付款周期" placeholder:@"请选择"];
    [bgSV addSubview:self.payCycleTf];
    self.payCycleTf.userInteractionEnabled = NO;
    UIControl *payCycleMaskCtrl = [[UIControl alloc] initWithFrame:self.payCycleTf.frame];
    [bgSV addSubview:payCycleMaskCtrl];
    [payCycleMaskCtrl addTarget:self action:@selector(payCycleTypeChoose) forControlEvents:UIControlEventTouchUpInside];
    
    //
    self.scyylmTf = [self tfWithFrame:CGRectMake(0, self.payCycleTf.yy, SCREEN_WIDTH, 45) leftTitle:@"擅长类目" placeholder:@"请选择"];
    [bgSV addSubview:self.scyylmTf];
    
    //
    self.scyylmTf = [self tfWithFrame:CGRectMake(0, self.feeModeTf.yy, SCREEN_WIDTH, 45) leftTitle:@"擅长类目" placeholder:@"请选择"];
    [bgSV addSubview:self.scyylmTf];
    
    //
    self.sucCaseTf = [self tfWithFrame:CGRectMake(0, self.scyylmTf.yy, SCREEN_WIDTH, 45) leftTitle:@"成功案例" placeholder:@"请选择"];
    [bgSV addSubview:self.sucCaseTf];
    
//    UIControl *maskCtrl = [[UIControl alloc] initWithFrame:self.isDingZhiTf.frame];
//    [bgSV addSubview:maskCtrl];
//    [maskCtrl addTarget:self action:@selector(chooseType) forControlEvents:UIControlEventTouchUpInside];
    
    
    //简介
    //    self.detailEditView = [[ZHGoodsDetailEditView alloc] initWithFrame:CGRectMake(0, self.self.priceTf.yy, SCREEN_WIDTH, 200)];
    //    self.detailEditView.placholder = @"请输入一些描述信息";
    //    self.detailEditView.typeNameLbl.text = @"描述";
    //    [bgSV addSubview:self.detailEditView];
    
    self.detailEditView.y = self.sucCaseTf.yy + 10;
    
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
    
//    [self saveWithCoverImg:self.shootModel ? self.shootModel.pic : nil];
    
}


- (BOOL)valitInput {
    
    
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
    
    
    return YES;
}


- (void)upLoadImageSuccessCoverImgKey:(NSString *)coverImageKey detailImageKeys:(NSString *)keys {
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
//    if (self.shootModel) {
//        
//        http.code = @"612082";
//        http.parameters[@"code"] = self.shootModel.code;
//        
//    } else {
//        
//        http.code = @"612080";
//        
//    }
    http.code = @"612110";
    http.parameters[@"name"] = self.nameTf.text;
    http.parameters[@"pic"] = coverImageKey;
    http.parameters[@"advPic"] = keys;
    http.parameters[@"companyCode"] = [CDCompany company].code;
    http.parameters[@"quoteMin"] = self.quoteMinTf.text;
    http.parameters[@"quoteMax"] = self.quoteMaxTf.text;
    http.parameters[@"qualityCode"] = [CDCompany company].gsQualify.code;
    http.parameters[@"description"] = self.detailEditView.detailTextView.text;
    http.parameters[@"publisher"] = [ZHUser user].userId;
    //
    http.parameters[@"pyNum"] = self.tgfwTf.text;
    http.parameters[@"feeMode"] = @"";
    http.parameters[@"payCycle"] = @"";
    http.parameters[@"scyylm"] = @"";
    http.parameters[@"sucCase"] = @"";

    
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
