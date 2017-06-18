//
//  ZHGoodsCell.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/13.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "CDDefaultCell.h"


@interface CDDefaultCell()




@end

@implementation CDDefaultCell

+ (CGFloat)rowHeight {
    return 95.0;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 65)];
        self.coverImageView.clipsToBounds = YES;
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.coverImageView];
        //        self.coverImageView.backgroundColor = [UIColor orangeColor];
        
        CGFloat w = SCREEN_WIDTH - self.coverImageView.xx - 20 - 70 - 10;
        self.mainTextLbl = [UILabel labelWithFrame:CGRectMake(self.coverImageView.xx + 10, self.coverImageView.y + 5, w , [[UIFont secondFont] lineHeight] + 1)
                                      textAligment:NSTextAlignmentLeft
                                   backgroundColor:[UIColor clearColor]
                                              font:[UIFont secondFont]
                                         textColor:[UIColor zh_textColor]];
        [self addSubview:self.mainTextLbl];
        
        
        self.subTextLbl =  [UILabel labelWithFrame:CGRectMake(self.coverImageView.xx + 10, self.mainTextLbl.yy + 3, self.mainTextLbl.width , 20)
                                      textAligment:NSTextAlignmentLeft
                                   backgroundColor:[UIColor whiteColor]
                                              font:[UIFont thirdFont]
                                         textColor:[UIColor colorWithHexString:@"#999999"]];
        [self addSubview:self.subTextLbl];
        
        //时间
        self.timeLbl = [UILabel labelWithFrame:CGRectMake(self.coverImageView.xx + 10, self.subTextLbl.yy + 3, self.mainTextLbl.width , 20)
                                  textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor whiteColor]
                                          font:[UIFont thirdFont]
                                     textColor:[UIColor colorWithHexString:@"#999999"]];
        [self addSubview:self.timeLbl];
        
        self.stateLbl =  [UILabel labelWithFrame:CGRectMake(0, self.mainTextLbl.y, 70 , self.mainTextLbl.height)
                                    textAligment:NSTextAlignmentRight
                                 backgroundColor:[UIColor whiteColor]
                                            font:[UIFont secondFont]
                                       textColor:[UIColor colorWithHexString:@"#999999"]];
        [self addSubview:self.stateLbl];
        self.stateLbl.xx_size = SCREEN_WIDTH - 10;
        
        
        
        //
        [self.stateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self.mainTextLbl.mas_right);
            //            make.right.greaterThanOrEqualTo(self.mainTextLbl.mas_right);
            
            make.top.equalTo(self.mainTextLbl.mas_top);
            make.right.equalTo(self.mas_right).offset(-5);
        }];
        
        //auto
        [self.mainTextLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.coverImageView.mas_right).offset(10);
            make.top.equalTo(self.coverImageView.mas_top).offset(5);
            
            make.right.lessThanOrEqualTo(self.stateLbl.mas_left);
            //            make.right.equalTo(self.stateLbl.mas_left);
        }];
        //
        [self.subTextLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mainTextLbl.mas_left);
            make.top.equalTo(self.mainTextLbl.mas_bottom).offset(5);
        }];
        
        //
        [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mainTextLbl.mas_left);
            make.top.equalTo(self.subTextLbl.mas_bottom).offset(5);
        }];
        
        [self.mainTextLbl setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.stateLbl setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        //        self.stateLbl.text = @"审核不通过";
        
        //line
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, [[self class] rowHeight] - 0.7, SCREEN_WIDTH, 0.7)];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:lineView];
        
    }
    
    return self;
    
}


@end
