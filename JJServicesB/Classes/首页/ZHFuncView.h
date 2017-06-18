//
//  ZHFuncView.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/22.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMsgBadgeView.h"

@interface ZHFuncView : UIView

- (instancetype)initWithFrame:(CGRect)frame funcName:(NSString *)funcName funcImage:(NSString *)imgName;

@property (nonatomic,assign) NSInteger msgCount;
@property (nonatomic,strong) void(^selected)(NSInteger index);
@property (nonatomic,assign) NSInteger index;

@property (nonatomic, strong) UILabel *nameLbl;


@property (nonatomic,strong) TLMsgBadgeView *msgBadgeView;

@end
