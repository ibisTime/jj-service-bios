//
//  UIImage+TLAdd.h
//  ZHBusiness
//
//  Created by  tianlei on 2017/6/26.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TLAdd)

- (void)zipBegin:(void(^)())beginHandler end:(void(^)(UIImage *))endHandler;
- (UIImage *)changImageColor:(UIColor *)targetColor blendModel:(CGBlendMode)mode;


@end
