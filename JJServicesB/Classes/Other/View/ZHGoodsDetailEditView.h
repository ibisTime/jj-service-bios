//
//  ZHGoodsDetailVC.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/15.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTextView.h"

@interface ZHGoodsDetailEditView : UIView

@property (nonatomic,strong) UILabel *typeNameLbl;
@property (nonatomic,copy) NSString *placholder;
//详情
@property (nonatomic,strong) TLTextView *detailTextView;
@property (nonatomic,assign) BOOL hiddenPhotoChoose;

//
@property (nonatomic,strong) NSMutableArray *images;

@property (nonatomic,assign) BOOL hiddenPhotoChooseBtn;


@end
