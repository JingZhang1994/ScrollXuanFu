//
//  ZJContentTableView.m
//  滚动悬浮
//
//  Created by apple on 2018/2/28.
//  Copyright © 2018年 zj. All rights reserved.
//

#import "ZJContentTableView.h"

@interface ZJContentTableView()<UITableViewDataSource>

@end
static NSString *NNContentTableViewCellID = @"NNContentTableView";
@implementation ZJContentTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.showsVerticalScrollIndicator = false;
    }
    return self;
}
-(void)didMoveToWindow{
    [super didMoveToWindow];
}
-(void)setContentOffset:(CGPoint)contentOffset{
    if (self.window) {
        [super setContentOffset:contentOffset];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NNContentTableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NNContentTableViewCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试:%ld", indexPath.row];
    return cell;
}

@end
