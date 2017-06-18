//
//  TLError.h
//  ZHBusiness
//
//  Created by  tianlei on 2017/6/4.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TLErrorType) {
    TLErrorTypeBiz,
    TLErrorTypeNet
    
};


@interface TLError : NSError

@property (nonatomic, assign) TLErrorType errorType;

@end
