//
//  CDImageUpLoadView.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/17.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDImageUpLoadView.h"

@implementation CDImageUpLoadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        //
        UILabel *hintlbl = [UILabel labelWithFrame:CGRectZero
                                      textAligment:NSTextAlignmentLeft
                                   backgroundColor:[UIColor whiteColor]
                                              font:FONT(15)
                                         textColor:[UIColor textColor]];
        [self addSubview:hintlbl];
        self.titleLbl=  hintlbl;
        
        self.placeholderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"身份证"]];
        [self addSubview:self.placeholderImageView];
        self.placeholderImageView.clipsToBounds = YES;
        self.placeholderImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.placeholderImageView.layer.cornerRadius = 4;
        self.placeholderImageView.layer.masksToBounds = YES;
        

        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.cornerRadius = 4;
        self.imageView.layer.masksToBounds = YES;
        
        //
        UIButton *chooseBtn = [UIButton zhBtnWithFrame:CGRectZero title:@"上传"];
        [self addSubview:chooseBtn];
        self.uploadBtn = chooseBtn;
        
        
        [hintlbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(hintlbl.mas_right).offset(60);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(55);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.top.equalTo(self.placeholderImageView);
        }];
        
        [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(60);
            make.right.equalTo(self.mas_right).offset(-60);
            
        }];

        
    }
    return self;
}

@end
