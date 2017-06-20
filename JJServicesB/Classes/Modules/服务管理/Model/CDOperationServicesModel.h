//
//  CDOperationServicesModel.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/20.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServiceBaseModel.h"

@interface CDOperationServicesModel : CDServiceBaseModel

@property (nonatomic, copy) NSString *tgfw;
@property (nonatomic, copy) NSString *feeMode;
@property (nonatomic, copy) NSString *payCycle ;
@property (nonatomic, copy) NSString *scyylm;
@property (nonatomic, copy) NSString *sucCase;


@property (nonatomic, copy, readonly) NSDictionary *payCycleDict;
@property (nonatomic, copy, readonly) NSDictionary *feeModeDict;
@property (nonatomic, copy, readonly) NSDictionary *tgfwDict;


@end
