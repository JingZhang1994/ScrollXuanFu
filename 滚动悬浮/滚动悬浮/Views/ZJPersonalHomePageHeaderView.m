//
//  ZJPersonalHomePageHeaderView.m
//  滚动悬浮
//
//  Created by apple on 2018/2/27.
//  Copyright © 2018年 zj. All rights reserved.
//

#import "ZJPersonalHomePageHeaderView.h"

@interface ZJPersonalHomePageHeaderView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *editInfoButton;
@end



@implementation ZJPersonalHomePageHeaderView

/*
 
 - hitTest: withEvent:方法的底层实现
 
 此底层实现说明了, 一个view的子控件是如何判断是否接收点击事件的.
 
 此方法返回的View是本次点击事件需要的最佳View
 看简书的链接：https://www.jianshu.com/p/ef83a798121c
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UIButton class]]) {
        return view;
    }
    return nil;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.nameLabel];
    [self addSubview:self.infoLabel];
    [self addSubview:self.editInfoButton];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-15);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(300);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.infoLabel.mas_top).offset(-10);
        make.centerX.mas_equalTo(self.infoLabel);
    }];
    [self.editInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.infoLabel);
        make.width.mas_equalTo(100);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _nameLabel.text            = @"n以梦为马";
        _nameLabel.textAlignment   = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor       = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        _infoLabel.text            = @"北京\n\n有三秋桂子，十里荷花\n\n写了100字，获得100个喜欢";
        _infoLabel.textAlignment   = NSTextAlignmentCenter;
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor       = [UIColor grayColor];
        _infoLabel.numberOfLines   = 0;
        _infoLabel.font            = [UIFont systemFontOfSize:11];
    }
    return _infoLabel;
}

- (UIButton *)editInfoButton {
    if (!_editInfoButton) {
        _editInfoButton                    = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editInfoButton setTitle:@"编辑个人资料" forState:UIControlStateNormal];
        _editInfoButton.titleLabel.font    = [UIFont boldSystemFontOfSize:11];
        [_editInfoButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _editInfoButton.layer.borderColor  = [UIColor redColor].CGColor;
        _editInfoButton.layer.cornerRadius = 2;
        _editInfoButton.layer.borderWidth  = 0.5f;
        [_editInfoButton addTarget:self action:@selector(clickedEditAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editInfoButton;
}

- (void)clickedEditAction:(UIButton *)sender {
    NSLog(@"你点击了编辑资料按钮");
}

@end
