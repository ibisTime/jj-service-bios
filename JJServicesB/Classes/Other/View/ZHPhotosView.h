//
//  ZHPhotosView.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/13.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPhotoView.h"

@interface ZHPhotosView : UIScrollView

//通过重新给该属性赋值，就可以刷新界面,  存储的不一定都是图片对象，------也可能是url
@property (nonatomic,strong) NSMutableArray *images;

@property (nonatomic,assign) NSInteger itemWidth;
@property (nonatomic,assign) CGSize itemSize;

@end


