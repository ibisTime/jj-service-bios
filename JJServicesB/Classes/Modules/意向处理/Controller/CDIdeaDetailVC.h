//
//  CDIdeaDetailVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLBaseVC.h"
#import "CDIdeaModel.h"

@interface CDIdeaDetailVC : TLBaseVC

@property (nonatomic, strong) CDIdeaModel *model;

@property (nonatomic, copy) void(^success)();

@end
