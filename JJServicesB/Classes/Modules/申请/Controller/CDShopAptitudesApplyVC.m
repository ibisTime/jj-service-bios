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


@end

@implementation CDShopAptitudesApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPlaceholderViewTitle:@"加载失败" operationTitle:@"重新加载"];
    
    self.title = @"申请资质";
    [self tl_placeholderOperation];
    
 
}

- (void)tl_placeholderOperation {

    //查资质
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"612016";
    //0 待审核 1 审核通过 2 审核不通过
    //    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
        [self removePlaceholderView];
        
        [self setUpUI];
        [self initData];
        self.aptitudeModles = [CDCompanyAptitudeModel tl_objectArrayWithDictionaryArray:responseObject[@"data"]];
        
    } failure:^(NSError *error) {
        
        [self addPlaceholderView];
        
    }];

}

//
- (void)initData {

    self.nameTf.text = [CDCompany company].name;

}

- (void)chooseAptitude {
    
    NSMutableArray <NSString *>*arr = [[NSMutableArray alloc] initWithCapacity:self.aptitudeModles.count];
    [self.aptitudeModles enumerateObjectsUsingBlock:^(CDCompanyAptitudeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [arr addObject:obj.name];
        
    }];
    TLPickerView *picker = [TLPickerView pickerView];
    picker.tagNames = arr;
    [picker show];
    

    [picker setDidSelect:^(NSInteger idx){
        
        self.currentAptitudeModel = self.aptitudeModles[idx];
        self.aptitudeChooseTf.text = self.currentAptitudeModel.name;
        
    }];
    
    
}


- (void)confirm {
    
    if (!self.currentAptitudeModel) {
        [TLAlert alertWithInfo:@"请选择公司资质"];
        return;
    }
    
    if (!self.sloganTf.text) {
        [TLAlert alertWithInfo:@"请输入广告语"];
        return;
    }
    
    if (!self.zoneTf.text) {
        [TLAlert alertWithInfo:@"请输入报价区间"];
        return;
    }
    

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    if (self.isRe) {
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
        
        [CDCompany company].gsQualify = [[CDCompanyAptitudeModel alloc] init];
        
        if (self.success) {
            
            self.success();
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)setUpUI {

    UIScrollView *bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:bgSV];
    
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
    
    
    //
    self.sloganTf = [self tfWithFrame:CGRectMake(0, self.aptitudeChooseTf.yy + 10, SCREEN_WIDTH, h) leftTitle:@"广告语"];
    [bgSV addSubview:self.sloganTf];
    self.sloganTf.placeholder = @"请输入广告语";

    
    //
    self.zoneTf = [self tfWithFrame:CGRectMake(0, self.sloganTf.yy, SCREEN_WIDTH, h) leftTitle:@"报价区间"];
    [bgSV addSubview:self.zoneTf];
    self.zoneTf.placeholder = @"请输入报价区间";
    
    //
    UIButton *confirmBtn = [UIButton zhBtnWithFrame:CGRectMake(30,self.zoneTf.yy +  60,SCREEN_WIDTH - 60, 45) title:@"确定"];
    [bgSV addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];

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
