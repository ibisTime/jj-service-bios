//
//  ZHFuncView.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/22.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHFuncView.h"

@implementation ZHFuncView


- (instancetype)initWithFrame:(CGRect)frame funcName:(NSString *)funcName funcImage:(NSString *)imgName {

    if (self = [super initWithFrame:frame]) {
        
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(funcBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor zh_textColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.width.equalTo(btn.mas_height);
        }];
        
        //
        TLMsgBadgeView *msgV = [[TLMsgBadgeView alloc] initWithFrame:CGRectMake(btn.width - 18, - 2, 20, 20)];
        //    msgV.xx_size = btn.width;
        [btn addSubview:msgV];
        _msgBadgeView = msgV;
        msgV.font = [UIFont systemFontOfSize:12];
        
        UILabel *funcLbl = [UILabel labelWithFrame:CGRectMake(0, btn.yy + 12, btn.width, 25)
                                      textAligment:NSTextAlignmentCenter
                                   backgroundColor:[UIColor whiteColor]
                                              font:[UIFont secondFont]
                                         textColor:[UIColor zh_textColor]];
        [self addSubview:funcLbl];
        funcLbl.text = funcName;
        self.nameLbl = funcLbl;
        
        [funcLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
        }];
        
    }
    
    return self;
    
}

- (void)setMsgCount:(NSInteger)msgCount {

    _msgCount = msgCount;
    _msgBadgeView.msgCount  = _msgCount;

}

- (void)funcBtnAction {

    if (self.selected) {
        self.selected(self.index);
    }

}

@end
