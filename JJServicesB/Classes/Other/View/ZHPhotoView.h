//
//  ZHPhotoView.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/13.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPhotoView : UIView

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIButton *deleteBtn;
//@property (nonatomic,copy)  void(^deleteImage)(UIImage *image);
@property (nonatomic,copy)  void(^deleteImage)(NSInteger index);


//在同级 元素里的位置
@property (nonatomic,assign) NSInteger index;

@end
