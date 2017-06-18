//
//  ZHPhotoView.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/13.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHPhotoView.h"
//#import "BPPhotoBrowser.h"

@implementation ZHPhotoView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        CGFloat btnW = 25;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width - 15, frame.size.width - 15)];
        [self addSubview:self.imageView];
//        self.imageView.backgroundColor = [UIColor cyanColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImg)];
        [self.imageView addGestureRecognizer:tap];
        
        
        self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - btnW - 5, 0, btnW, btnW)];
        [self.deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [self addSubview:self.deleteBtn];
        [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)scaleImg {

//    BPPhotoBrowser *photoB = [[BPPhotoBrowser alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    photoB.image = self.imageView.image;
//    [UIView animateWithDuration:0.25 animations:^{
//        
//        [[UIApplication sharedApplication].keyWindow addSubview:photoB];
//
//        
//    }];


}

- (void)deleteAction {

    if (self.deleteImage) {
        
        self.deleteImage(self.index);
        
    }
    
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imgDelete_zh_zdd" object:nil];
    //告诉外界哪个图片被移除了

}
@end
