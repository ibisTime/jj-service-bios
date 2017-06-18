//
//  XNBannerView.h
//  MOOM
//
//  Created by 田磊 on 16/4/12.
//  Copyright © 2016年 田磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLBannerView : UIView

//- (instancetype)initWithFrame:(CGRect)frame urlString:(NSArray <NSString *>*)urls;

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,assign) BOOL isAuto;

@property (nonatomic,strong) NSArray *imgUrls;

@property (nonatomic,copy) void(^bannerBlock)(NSInteger index);

@end

