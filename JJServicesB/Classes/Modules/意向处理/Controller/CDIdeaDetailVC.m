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

@end

@implementation CDIdeaDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    

}

- (void)setUpUI {
    
    UIScrollView *bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:bgSV];
    
    
    //
    self.nameTf = [self tfWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 45) leftTitle:@"意向人" placeholder:nil];
    [bgSV addSubview:self.nameTf];
    
    //
    self.phoneTf = [self tfWithFrame:CGRectMake(0, self.nameTf.yy, SCREEN_WIDTH, 45) leftTitle:@"联系方式" placeholder:@""];
    [bgSV addSubview:self.phoneTf];
    
    //
    self.descTf = [self tfWithFrame:CGRectMake(0, self.phoneTf.yy, SCREEN_WIDTH, 45) leftTitle:@"意向描述" placeholder:@""];
    [bgSV addSubview:self.descTf];
    
    self.timeTf = [self tfWithFrame:CGRectMake(0, self.descTf.yy, SCREEN_WIDTH, 45) leftTitle:@"意向时间" placeholder:@""];
    [bgSV addSubview:self.timeTf];
    
    self.statusTf = [self tfWithFrame:CGRectMake(0, self.timeTf.yy, SCREEN_WIDTH, 45) leftTitle:@"意向状态" placeholder:@""];
    [bgSV addSubview:self.statusTf];
    
    self.resultTf = [self tfWithFrame:CGRectMake(0, self.statusTf.yy, SCREEN_WIDTH, 45) leftTitle:@"洽谈结果" placeholder:@""];
    [bgSV addSubview:self.resultTf];
    
  
    //
    UIButton *confirmBtn = [UIButton zhBtnWithFrame:CGRectMake(20, self.resultTf.yy + 30, SCREEN_WIDTH - 40, 45) title:@"我已洽谈"];
    [bgSV addSubview:confirmBtn];
    
    UILabel *hintLbl = [UILabel labelWithFrame:CGRectMake(20, confirmBtn.yy + 10, confirmBtn.width, 20) textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor clearColor]
                                          font:FONT(14)
                                     textColor:[UIColor textColor]];
    
    [bgSV addSubview:hintLbl];
//    hintLbl.text = @"点击确认后将会有工作人员与您联系";
    
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


@end
