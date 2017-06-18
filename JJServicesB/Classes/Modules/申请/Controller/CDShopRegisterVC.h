//
//  CDShopRegisterVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/15.
//  Copyright © 2017年  tianlei. All rights reserved.
//  店铺注册

#import "TLBaseVC.h"

typedef NS_ENUM(NSUInteger, RegisterType) {
    RegisterTypePersonal,
    RegisterTypeEnterprise
};
@interface CDShopRegisterVC : TLBaseVC

@property (nonatomic, assign) RegisterType type;

@end
