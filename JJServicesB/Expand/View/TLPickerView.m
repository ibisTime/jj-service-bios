//
//  TLPickerView.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/16.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLPickerView.h"

@interface TLPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation TLPickerView


+ (instancetype)pickerView {

    TLPickerView *pickerView = [[TLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    
 
    //
    
    
    return pickerView;
    //

}

//
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        [self addTarget:self action:@selector(remove
                                                    ) forControlEvents:UIControlEventTouchUpInside];
        
        //
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
        picker.delegate = self;
        picker.dataSource = self;
        picker.backgroundColor = [UIColor whiteColor];
        self.pickerView = picker;
        [self addSubview:picker];
        //
        [picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(180);
        }];
        
        //
        UIView *toolBarView = [[UIView alloc] init];
        [self addSubview:toolBarView];
        toolBarView.backgroundColor = [UIColor whiteColor];
        [toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@44);
            make.bottom.equalTo(picker.mas_top);
            
        }];
        
        
        //
        UIButton *canclebtn = [self btnWithTitle:@"取消"];
        [toolBarView addSubview:canclebtn];
        [canclebtn setTitleColor:[UIColor textColor2] forState:UIControlStateNormal];
        [canclebtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        //
        UIButton *confirmBtn = [self btnWithTitle:@"确定"];
        [toolBarView addSubview:confirmBtn];
        [confirmBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
        [canclebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(toolBarView.mas_height);
            make.left.equalTo(toolBarView.mas_left).offset(15);
            make.centerY.equalTo(toolBarView.mas_centerY);
        }];
        
        //
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(toolBarView.mas_height);
            make.right.equalTo(toolBarView.mas_right).offset(-15);
            make.centerY.equalTo(toolBarView.mas_centerY);
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lineColor];
        [toolBarView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(toolBarView.mas_left);
            make.width.equalTo(toolBarView.mas_width);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(toolBarView.mas_bottom);
        }];
        
    }
    
    return self;
    
}

- (void)confirm {

    [self remove];
    if (self.didSelect) {
        
        self.didSelect([self.pickerView selectedRowInComponent:0]);
        
    }
    

}


- (void)cancle {
    
    [self remove];
    
}


//
- (UIButton *)btnWithTitle:(NSString *)title {

    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(15);
    return btn;

}

- (void)remove {

    [self removeFromSuperview];

}

//
- (void)show {

    if (!self.tagNames || self.tagNames.count <= 0) {
        
        return;
    }

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.pickerView reloadAllComponents];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.tagNames.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return  self.tagNames[row];
    
}



@end
