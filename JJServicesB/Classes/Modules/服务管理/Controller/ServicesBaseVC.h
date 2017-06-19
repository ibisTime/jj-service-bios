//
//  ServicesBaseVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLBaseVC.h"
#import "ZHGoodsDetailEditView.h"

@interface ServicesBaseVC : TLBaseVC

@property (nonatomic, strong) UIScrollView *bgSV;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *coverImageView;

////
//@property (nonatomic, strong) TLTextField *quoteMinTf;
//@property (nonatomic, strong) TLTextField *quoteMaxTf;

//
@property (nonatomic, strong) ZHGoodsDetailEditView *detailEditView;


/**
 子类应复写该方法
 */
//- (BOOL)valitInput;

/**
 子类调用该方法进行图片上传操作
 */
- (void)saveWithCoverImg:(NSString *)hasCoverImgStr;

/**
 子类应该事先该方法
 */
- (void)upLoadImageSuccessCoverImgKey:(NSString *)coverImageKey detailImageKeys:(NSString *)keys;

@end
