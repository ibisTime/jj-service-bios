//
//  CDImageUpLoadView.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/17.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDImageUpLoadView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UIImageView *placeholderImageView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *uploadBtn;
@property (nonatomic, strong) UILabel *titleLbl;
@end
