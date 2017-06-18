//
//  CDDefaultCell.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLBaseVC.h"

@interface CDDefaultCell : UITableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *mainTextLbl;
@property (nonatomic, strong) UILabel *subTextLbl;
@property (nonatomic, strong) UILabel *stateLbl;
@property (nonatomic, strong) UILabel *timeLbl;

+ (CGFloat)rowHeight;

@end
