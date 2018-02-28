//
//  ZJContentScrollView.m
//  滚动悬浮
//
//  Created by apple on 2018/2/27.
//  Copyright © 2018年 zj. All rights reserved.
//

#import "ZJContentScrollView.h"

@implementation ZJContentScrollView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        self.showsVerticalScrollIndicator = false;
    }
    return self;
}

- (void)setOffset:(CGPoint)offset {
    _offset = offset;
}
//判断什么时候底部的scrollview可以滑动，什么时候不可以
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view       = [super hitTest:point withEvent:event];
    BOOL hitHead       = point.y < (ZJHeadViewHeight - self.offset.y);
    if (hitHead || !view) {
        self.scrollEnabled = NO;
        if (!view) {
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x) {
                    view = subView;
                }
            }
        }
        return view;
    } else {
        self.scrollEnabled = YES;
        return view;
    }
}

@end
