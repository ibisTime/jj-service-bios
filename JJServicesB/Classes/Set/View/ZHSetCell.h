//
//  ZHSetCell.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHSetItem.h"

@interface ZHSetCell : UITableViewCell

@property (nonatomic,strong) ZHSetItem *setItem;
@property (nonatomic,strong) UILabel *infoLbl;
@property (nonatomic,strong) UISwitch *switchView;

@property (nonatomic,copy) void(^switchAction)(BOOL on);

@end
