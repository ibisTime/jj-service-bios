//
//  TLTextView.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/13.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLTextView.h"

@interface TLTextView()<UITextViewDelegate>


@end


@implementation TLTextView

- (UILabel *)placeholderLbl {

    if (!_placeholderLbl) {
        _placeholderLbl =  [UILabel labelWithFrame:CGRectZero
                                             textAligment:NSTextAlignmentLeft
                                          backgroundColor:[UIColor whiteColor]
                                                     font:FONT(15)
                                                textColor:[UIColor colorWithHexString:@"#999999"]];
        _placeholderLbl.userInteractionEnabled = YES;
        _placeholderLbl.numberOfLines = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEdit)];
        [_placeholderLbl addGestureRecognizer:tap];
    }
    return _placeholderLbl;

}
- (void)beginEdit {

    [self becomeFirstResponder];

}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        [self addSubview:self.placeholderLbl];
        [self addPlaceholderLblYS];

        
        //
    }

    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];

}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//
//    if (self =[super initWithCoder:aDecoder]) {
//        
//
//        
//    }
//    return self;
//
//}
- (void)setText:(NSString *)text {

    [super setText:text];
    [self.placeholderLbl removeFromSuperview];
}

- (void)setPlacholder:(NSString *)placholder {

    _placholder = [placholder copy];
    self.placeholderLbl.text = _placholder;
    
}

#pragma mark- textView delegate

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length > 0) {
        
        [self.placeholderLbl removeFromSuperview];
        
    } else {
        
        [self addSubview:self.placeholderLbl];
        [self addPlaceholderLblYS];
        
    }
    
    
}

- (void)addPlaceholderLblYS {

    [self.placeholderLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(7);
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self.mas_top).offset(7);
        make.width.lessThanOrEqualTo(@(self.width - 12));
//        make.height.mas_greaterThanOrEqualTo(30);
        
    }];

}
@end
