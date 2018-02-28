//
//  ZJPersonalHomePageTitleView.h
//  滚动悬浮
//
//  Created by apple on 2018/2/28.
//  Copyright © 2018年 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJPersonalHomePageTitleView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) void (^buttonSelected)(NSInteger index);
@end
