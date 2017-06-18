//
//  CDServicesInfoChangeVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServicesInfoChangeVC.h"
#import "ZHGoodsDetailEditView.h"

@interface CDServicesInfoChangeVC ()

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) TLTextField *nameTf;
@property (nonatomic, strong) TLTextField *priceTf;

@property (nonatomic, strong) ZHGoodsDetailEditView *detailEditView;

@end

@implementation CDServicesInfoChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {

    UIScrollView *bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:bgSV];
    
    //
    UIView *headerV = [self setUpTableViewHeaderView];
    [bgSV addSubview:headerV];
    
    //
    self.nameTf = [self tfWithFrame:CGRectMake(0, headerV.yy + 10, SCREEN_WIDTH, 45) leftTitle:@"名称" placeholder:@"请输入名称"];
    [bgSV addSubview:self.nameTf];
    
    //
    self.priceTf = [self tfWithFrame:CGRectMake(0, self.nameTf.yy, SCREEN_WIDTH, 45) leftTitle:@"价格" placeholder:@"请输入价格"];
    [bgSV addSubview:self.priceTf];
    
    //
    //简介
    self.detailEditView = [[ZHGoodsDetailEditView alloc] initWithFrame:CGRectMake(0, self.self.priceTf.yy, SCREEN_WIDTH, 200)];
    self.detailEditView.placholder = @"请输入一些描述信息";
    self.detailEditView.typeNameLbl.text = @"描述";
    [bgSV addSubview:self.detailEditView];
    
    //
    UIButton *confirmBtn = [UIButton zhBtnWithFrame:CGRectMake(20, self.detailEditView.yy + 30, SCREEN_WIDTH - 40, 45) title:@"确认"];
    [bgSV addSubview:confirmBtn];
    
    UILabel *hintLbl = [UILabel labelWithFrame:CGRectMake(20, confirmBtn.yy + 10, confirmBtn.width, 20) textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor clearColor]
                                          font:FONT(14)
                                     textColor:[UIColor textColor]];
    
    [bgSV addSubview:hintLbl];
    hintLbl.text = @"点击确认后将会有工作人员与您联系";
    
    bgSV.contentSize = CGSizeMake(SCREEN_WIDTH, hintLbl.yy  +10);

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


- (UIView *)setUpTableViewHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    headerView.backgroundColor = [UIColor whiteColor];
    //图片选择手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImg)];
    [headerView addGestureRecognizer:tap];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 5, 100, 25) textAligment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] font:[UIFont secondFont] textColor:[UIColor zh_textColor]];
    [headerView addSubview:nameLbl];
    nameLbl.centerY = headerView.height/2.0;
    nameLbl.text = @"公司封面";
    //    self.coverHintLbl = nameLbl;
    
    //
    UIImageView *shopCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 60)];
    shopCoverImageView.image = [UIImage imageNamed:@"商铺"];
    shopCoverImageView.xx_size = SCREEN_WIDTH - 20;
    shopCoverImageView.clipsToBounds = YES;
    shopCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    shopCoverImageView.centerY = headerView.height/2.0;
    [headerView addSubview:shopCoverImageView];
    self.coverImageView = shopCoverImageView;
    
    
    return headerView;
    
}

@end
