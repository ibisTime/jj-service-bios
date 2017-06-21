//
//  ZHPhotosView.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/13.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHPhotosView.h"

@interface ZHPhotosView()

@property (nonatomic,strong) UIView *bgView;


@end

@implementation ZHPhotosView
{
    NSInteger _lastImageCount;
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)itemWidth {

    if (_itemWidth == 0) {
        
        self.itemWidth = 60;
    }

    return _itemWidth;
}

- (UIView *)bgView {

    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_bgView];
    }
    return _bgView;

}

- (CGSize)itemSize {

    if (_itemSize.width == 0 || _itemSize.height == 0) {
        _itemSize = CGSizeMake(75, 70);
    }

    return _itemSize;
    
}

- (void)setImages:(NSMutableArray *)images {

    if (!images) {
        return;
    }
    _images = images;
    
#pragma mark- 每次更能图片
    [self changeImages];

    
}

- (instancetype)init {

    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutSubViewAction) name:@"imgDelete_zh_zdd" object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutSubViewAction) name:@"imgDelete_zh_zdd" object:nil];
    }
    return self;

}




////////////////////
- (void)changeImages {
    
    if(!_images){
        return;
    }
    
    //NSInteger subViewCount = self.subviews.count;
    //NSArray *subViews = self.subviews;
    
    NSInteger subViewCount = self.bgView.subviews.count;
    NSArray *subViews = self.bgView.subviews;
    
    if (_images.count == 0) {//移除所有子视图
        
        for (NSInteger i = 0; i < subViewCount; i ++) {
            UIView *v = subViews[i];
            [v removeFromSuperview];
        }
        return;
    }
    
    
    if (subViewCount == 0) {
        
        for (NSInteger i = 0; i < _images.count ; i ++) {
            
            CGFloat x = i*(self.itemSize.width);
            ZHPhotoView *photo = [[ZHPhotoView alloc] initWithFrame:CGRectMake(x, 0, self.itemSize.width, self.itemSize.height)];
            __weak typeof(self) weakSelf = self;
            photo.index = i;
            photo.deleteImage = ^(NSInteger index){
            
                [weakSelf.images removeObjectAtIndex:index];
                
            };
            [self.bgView addSubview:photo];
            
        }
        
        
    } else {
        
        if (subViewCount > _images.count) {
            //1.子视图 比 > 图片数量
            
            NSInteger dValue = subViewCount - _images.count;
            for (NSInteger i = 0; i < dValue; i ++) {
                
                UIView *subV = self.bgView.subviews[subViewCount - 1];
                [subV removeFromSuperview];
            }
            
        } else if(subViewCount == _images.count){
        
            for (NSInteger i = 0; i < subViewCount; i ++) {
                ZHPhotoView *v = subViews[i];
                CGFloat x = i*(self.itemSize.width);
                v.index = i;
                v.frame = CGRectMake(x, 0, self.itemSize.width, self.itemSize.height);
            }
        
        } else {
            
            //2.子视图个数 < 图片数量
            NSInteger dValue = _images.count - subViewCount;
            for (NSInteger i = 0; i < dValue; i ++) {
                
                ZHPhotoView *photo = [[ZHPhotoView alloc] initWithFrame:CGRectMake(subViewCount * self.itemSize.width, 0, self.itemSize.width, self.itemSize.height)];
                __weak typeof(self) weakSelf = self;
                photo.index = subViewCount - 1 + i;
                photo.deleteImage = ^(NSInteger index){
                    
                    [weakSelf.images removeObjectAtIndex:index];
                    
                };
                [self.bgView addSubview:photo];
            }
            
       }
        
    }
    
    
    //保证子视图和图片数量相等
    [self.bgView.subviews enumerateObjectsUsingBlock:^(__kindof ZHPhotoView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //重新赋值idx
        obj.index = idx;
        
        //
        id tempImg = _images[idx];
        if ([tempImg isKindOfClass:[NSString class]]) {
            
            NSString *url = (NSString *)tempImg;
            [obj.imageView sd_setImageWithURL:[NSURL URLWithString:[url convertThumbnailImageUrl]] placeholderImage:[UIImage imageNamed:@"商铺"]];
        } else {
        
            obj.imageView.image = tempImg;

        }
        
    }];
    _lastImageCount = _images.count;
    
    UIView *lastView = self.bgView.subviews[self.bgView.subviews.count - 1];
    if (lastView.xx > self.width) {
        
        self.bgView.width = lastView.xx;
        self.contentSize = CGSizeMake(lastView.xx, self.height);
    }
   

}

- (void)layoutSubViewAction {
    
    [self layoutSubviews];
}

//子视图，增加，减少都会调用该方法
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_lastImageCount > self.bgView.subviews.count) {
       [self changeImages];

    }

}

@end
