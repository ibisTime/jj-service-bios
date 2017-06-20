//
//  CDServiceBaseModel.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLBaseModel.h"

@interface CDServiceBaseModel : TLBaseModel

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *advPic;
@property (nonatomic, copy, readonly) NSArray <NSString *>*detailPics;

@property (nonatomic, copy) NSString *name;

//1 正常 0 违规
@property (nonatomic, copy) NSString *status;

//
@property (nonatomic, strong) NSNumber *quoteMax;
@property (nonatomic, strong) NSNumber *quoteMin;

//
@property (nonatomic, strong) NSString *desc;

- (NSString *)getStatusName;

@end
