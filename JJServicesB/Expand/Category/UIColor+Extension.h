//
//  UIColor+Extension.h
//  MOOM
//
//  Created by 田磊 on 16/4/25.
//  Copyright © 2016年 田磊. All rights reserved.
//

#import <UIKit/UIKit.h>


#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

@interface UIColor (Extension)

- (UIImage*)convertToImage;
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)backgroundColor;

@end
