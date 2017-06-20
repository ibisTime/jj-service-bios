//
//  CDServicesInfoChangeVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDIdeaDetailVC.h"
#import "ZHGoodsDetailEditView.h"

@interface CDIdeaDetailVC ()

@property (nonatomic, strong) TLTextField *nameTf;
@property (nonatomic, strong) TLTextField *phoneTf;

@property (nonatomic, strong) TLTextField *descTf;
@property (nonatomic, strong) TLTextField *timeTf;
@property (nonatomic, strong) TLTextField *statusTf;
@property (nonatomic, strong) TLTextField *resultTf;


@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation CDIdeaDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.model.status isEqualToString:@"1"]) {
        
        
    }
    
    [self setUpUI];
    
    //      意向状态：APPLY("1", "未查看"), PASS_YES("2", "已查看/处理通过"), PASS_NO("3", "不通过");

    self.title = @"意向处理";
    [self initData];
    
    if ([self.model.status isEqualToString:@"1"]) {
        
        self.confirmBtn.hidden = NO;
        self.resultTf.enabled = YES;

    } else {
    
        self.confirmBtn.hidden = YES;
        self.resultTf.enabled = NO;


    }

 

}

- (void)initData {

    self.nameTf.text = self.model.intName;
    self.phoneTf.text = self.model.intMobile;
    
    //意向描述
    self.timeTf.text = [self.model.submitDatetime convertToDetailDate];
    self.statusTf.text  = [self.model getStatusName];
    self.resultTf.text = self.model.remark;
    
//    self.descTf.text=  self.model.hzContent;
}

- (void)complection {
    
    if (![self.resultTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入洽谈结果"];
        return;
    }

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"612173";
    http.parameters[@"code"] = self.model.code;;
    http.parameters[@"dealResult"] = @"1";
    http.parameters[@"updater"] = [ZHUser user].userId;
    http.parameters[@"remark"] = self.resultTf.text;

    
    
    [http postWithSuccess:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        if (self.success) {
            self.success();
        }
    } failure:^(NSError *error) {
        
    }];



}


- (void)setUpUI {
    
    UIScrollView *bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:bgSV];
    bgSV.backgroundColor = [UIColor whiteColor];
    
    //
    self.nameTf = [self tfWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 45) leftTitle:@"意向人" placeholder:nil bottomLineHidden:NO topLineHidden:YES];
    [bgSV addSubview:self.nameTf];
    self.nameTf.userInteractionEnabled  = NO;
    
    //
    self.phoneTf = [self tfWithFrame:CGRectMake(0, self.nameTf.yy, SCREEN_WIDTH, 45) leftTitle:@"联系方式" placeholder:@"" bottomLineHidden:NO topLineHidden:YES];
    [bgSV addSubview:self.phoneTf];
    self.phoneTf.userInteractionEnabled  = NO;

    
    //
    UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, self.phoneTf.yy, SCREEN_WIDTH, 0)];
    bgV.backgroundColor = [UIColor whiteColor];
    [bgSV addSubview:bgV];
    
    //
    self.descTf = [self tfWithFrame:CGRectMake(0, self.phoneTf.yy, SCREEN_WIDTH, 45) leftTitle:@"意向描述" placeholder:@"" bottomLineHidden:YES topLineHidden:YES];
    [bgSV addSubview:self.descTf];
    self.descTf.userInteractionEnabled  = NO;

    CGFloat top = 15;
    UILabel *descLbl = [UILabel labelWithFrame:CGRectMake(110, self.descTf.y + top, 0, 0
                                                          ) textAligment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor
                                                                                                        ] font:FONT(15)
                                     textColor:[UIColor textColor]];
    [bgSV addSubview:descLbl];
    descLbl.numberOfLines = 0;
    descLbl.text = self.model.hzContent;
    
    CGFloat w = SCREEN_WIDTH - 15 - 110;
    CGSize size = [descLbl sizeThatFits:CGSizeMake(w, MAXFLOAT)];
    descLbl.size = size;

    
    self.timeTf = [self tfWithFrame:CGRectMake(0, descLbl.yy, SCREEN_WIDTH, 45) leftTitle:@"意向时间" placeholder:@"" bottomLineHidden:NO topLineHidden:NO];
    [bgSV addSubview:self.timeTf];
    self.timeTf.userInteractionEnabled  = NO;
    
    if (size.height > self.descTf.height - top) {
        

    } else {
    
        self.timeTf.y = self.descTf.yy;

    }
    
    
  

    
    self.statusTf = [self tfWithFrame:CGRectMake(0, self.timeTf.yy, SCREEN_WIDTH, 45) leftTitle:@"意向状态" placeholder:@"" bottomLineHidden:NO topLineHidden:YES];
    [bgSV addSubview:self.statusTf];
    self.statusTf.userInteractionEnabled  = NO;

    
    self.resultTf = [self tfWithFrame:CGRectMake(0, self.statusTf.yy, SCREEN_WIDTH, 45) leftTitle:@"洽谈结果" placeholder:@"" bottomLineHidden:NO topLineHidden:YES];
    [bgSV addSubview:self.resultTf];
    self.resultTf.placeholder = @"请输入洽谈结果";

    
  
    //
    UIButton *confirmBtn = [UIButton zhBtnWithFrame:CGRectMake(20, self.resultTf.yy + 30, SCREEN_WIDTH - 40, 45) title:@"我已洽谈"];
    [bgSV addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
    [confirmBtn addTarget:self action:@selector(complection) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *hintLbl = [UILabel labelWithFrame:CGRectMake(20, confirmBtn.yy + 10, confirmBtn.width, 20) textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor clearColor]
                                          font:FONT(14)
                                     textColor:[UIColor textColor]];
    
    [bgSV addSubview:hintLbl];
//    hintLbl.text = @"点击确认后将会有工作人员与您联系";
    
    bgSV.contentSize = CGSizeMake(SCREEN_WIDTH, hintLbl.yy  +10);
    
    
    
}

//- (UIView *)viewWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle content:(NSString *)content {
//
//    
//    UIView *v = [[UIView alloc] initWithFrame:frame];
//    
//    UILabel *leftTitleLbl = [UILabel labelWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) textAligment:<#(NSTextAlignment)#> backgroundColor:<#(UIColor *)#> font:<#(UIFont *)#> textColor:<#(UIColor *)#>];
//
//
//}

- (TLTextField *)tfWithFrame:(CGRect)frame leftTitle:(NSString *)title placeholder:(NSString *)placeholder bottomLineHidden:(BOOL)bottomLineHidden topLineHidden:(BOOL)toplineHidden {
    
    TLTextField *tf = [[TLTextField alloc] initWithframe:frame leftTitle:title titleWidth:110 placeholder:placeholder];
    
    if (!toplineHidden) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lineColor];
        [tf addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tf);
            make.height.mas_equalTo(0.5);
            make.top.equalTo(tf.mas_top);
        }];
    }
    
    if (!bottomLineHidden) {
    
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lineColor];
        [tf addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tf);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(tf.mas_bottom);
        }];
    
    }

    return tf;
    
}


@end
