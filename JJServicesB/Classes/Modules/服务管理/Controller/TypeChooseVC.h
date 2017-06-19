//
//  TypeChooseVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLBaseVC.h"
#import "TypeModel.h"

@interface TypeChooseVC : TLBaseVC


@property (nonatomic, copy) void(^selected)(TypeModel *type);

@property (nonatomic, copy) NSArray< TypeModel *> *typeArrays;


@end
