//
//  ZHShopInfoChangeVC.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/13.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLBaseVC.h"

@interface ZHShopInfoChangeVC : TLBaseVC

@property (nonatomic,assign) BOOL alreadyApply;
@property (nonatomic,strong) void(^success)();
@end
