//
//  TLPickerView.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/16.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLPickerView : UIControl

+ (instancetype)pickerView;

//
- (void)show;
//
@property (nonatomic,copy) NSArray *tagNames;

@property (nonatomic,copy)  void (^didSelect)(NSInteger index);

@end
