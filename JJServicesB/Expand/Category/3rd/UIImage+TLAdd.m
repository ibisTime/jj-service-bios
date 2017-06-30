//
//  UIImage+TLAdd.m
//  ZHBusiness
//
//  Created by  tianlei on 2017/6/26.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "UIImage+TLAdd.h"

@implementation UIImage (TLAdd)


/**
 @param oldImg 需要压缩的图片
 @param beginHandler 开始
 @param endHandler 完成的回调
 */
- (void)zipBegin:(void(^)())beginHandler end:(void(^)(UIImage *))endHandler {
    
    if (beginHandler) {
        beginHandler();
    }
    
    UIImage *oldImg = self;
    
   
    if (!oldImg) {
        endHandler(nil);
        return;
    }
    
    //    NSLog(@"old:%f",[self M_img:oldImg]);
    
    
    CGFloat H_W = oldImg.size.height/oldImg.size.width;
    if (H_W < 0.3333 || UIImageJPEGRepresentation(oldImg, 1).length < 0.5*1024*1024 ) {
        //宽图，暂不压缩
        //小于0.5M,暂不压缩
        
        if (endHandler) {
            endHandler(oldImg);
            return;
        }
        
    }
    
    //image 中size为point 但是这决定于 image的scale属性，scale == 1时 image pt == px
    CGFloat zeroW_PX = 1080;
    
    // 2X  1point = 4px;
    // 3X  1point = 9px;
    CGFloat imgScale = oldImg.scale;
    
    //正常图片
    //长图 H_W > 3.0
    CGFloat animationW = zeroW_PX/imgScale;
    
    if (oldImg.size.width <= animationW) {
        
        if (endHandler) {
            endHandler(oldImg);
            return;
        }
        
    }
    
    CGFloat zipScale = oldImg.size.width/animationW;
    CGSize targetSize = CGSizeMake(animationW, oldImg.size.height/zipScale);
    
    
    //*****1.图片缩操作，减小像素数，和尺寸*******//
    //开画布
    UIGraphicsBeginImageContext(targetSize);
    
    [oldImg drawInRect:CGRectMake(0, 0, targetSize.width,targetSize.height)];
    //新图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭画布
    UIGraphicsEndImageContext();
    
    //*****2.图片压操作*******//
    UIImage *lastImg = [UIImage imageWithData:UIImageJPEGRepresentation(newImg, 0.7)];
    
    
    //    NSLog(@"old:%f - new:%f--%f",[self M_img:oldImg],[self M_img:newImg],UIImageJPEGRepresentation(newImg, 0.7).length/(1024*1024.0));
    
    //    UIImageWriteToSavedPhotosAlbum(lastImg
    //, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    if (endHandler) {
        endHandler(lastImg);
    }
}


- (UIImage *)changImageColor:(UIColor *)targetColor blendModel:(CGBlendMode)mode
{
    
    if (!self) {
        return nil;
    }
    
    UIImage *image = self;
    
    CGSize orgSize = CGSizeMake(image.size.width/image.scale, image.size.height/image.scale);
    
    //获取画布
    UIGraphicsBeginImageContext(orgSize);
    //画笔沾取颜色
    [targetColor setFill];
    
    CGRect drawRect = CGRectMake(0, 0, orgSize.width, orgSize.height);
    UIRectFill(drawRect);
    [image drawInRect:drawRect blendMode:mode alpha:1];
    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
