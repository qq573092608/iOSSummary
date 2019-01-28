//
//  ZoomFooterView.m
//  ImgBrower
//
//  Created by 黄小刚 on 2019/1/27.
//  Copyright © 2019年 黄小刚. All rights reserved.
//

#import "ZoomFooterView.h"
#import "Masonry.h"

@interface ZoomFooterView()
{
    
}

@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation ZoomFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    [self addSubview:self.moreBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
}

#pragma mark - ####### Lazy loadß #######
- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_moreBtn addTarget:self
                     action:@selector(showMore:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (void)showMore:(UIButton *)btn
{
    
    
    
}



@end
