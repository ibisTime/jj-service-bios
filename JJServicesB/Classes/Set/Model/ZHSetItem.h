//
//  ZHSetItem.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NS_ENUM(NSInteger,ZHSetItemAccessoryType) {

    ZHSetItemAccessoryTypeArrow = 0,
    ZHSetItemAccessoryTypeSwitch,
    ZHSetItemAccessoryTypeLabel
};


@interface ZHSetItem : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) ZHSetItemAccessoryType type;
@property (nonatomic,copy) void(^action)();
@property (nonatomic,copy) void(^switchAction)(BOOL on);
;

@end
