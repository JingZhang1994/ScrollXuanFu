//
//  ZJViewController.m
//  滚动悬浮
//
//  Created by apple on 2018/2/27.
//  Copyright © 2018年 zj. All rights reserved.
//

#import "ZJViewController.h"
#import "ZJPersonalHomePageHeaderView.h"
#import "ZJContentScrollView.h"
#import "ZJContentTableView.h"
#import "ZJPersonalHomePageTitleView.h"
@interface ZJViewController ()<UIScrollViewDelegate, UITableViewDelegate>
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) ZJContentScrollView *scrollView;
@property (nonatomic, weak) ZJContentTableView *dynamicTableView;
@property (nonatomic, weak) ZJContentTableView *articleTableView;
@property (nonatomic, weak) ZJContentTableView *moreTableView;
@property (nonatomic, weak) ZJContentTableView *moreTableView1;
@property (nonatomic, weak) ZJPersonalHomePageTitleView *titleView;
@property (nonatomic, weak) UIView *tableViewHeadView;
@end

@implementation ZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;//ViewController的布局属性
    [self setupContentView];
    [self setupHeaderView];

}
//主要内容
-(void)setupContentView{
    ZJContentScrollView *scrollView           = [[ZJContentScrollView alloc] init];
    scrollView.delaysContentTouches           = NO;
    [self.view addSubview:scrollView];
    self.scrollView                           = scrollView;
    scrollView.pagingEnabled                  = YES;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate                       = self;
    scrollView.contentSize                    = CGSizeMake(Width * 4, 0);
    UIView *headView                          = [[UIView alloc] init];
    headView.frame                            = CGRectMake(0, 0, 0, ZJHeadViewHeight + ZJTitleHeight);
    self.tableViewHeadView = headView;
    
    ZJContentTableView *dynamicTableView = [[ZJContentTableView alloc] init];
    dynamicTableView.delegate            = self;
    dynamicTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.dynamicTableView                = dynamicTableView;
    dynamicTableView.tableHeaderView     = headView;
    [scrollView addSubview:dynamicTableView];
    [dynamicTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.width.mas_equalTo(Width);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    ZJContentTableView *articleTableView = [[ZJContentTableView alloc] init];
    articleTableView.delegate            = self;
    articleTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.articleTableView                = articleTableView;
    articleTableView.tableHeaderView     = headView;
    [scrollView addSubview:articleTableView];
    [articleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(Width);
        make.width.equalTo(dynamicTableView);
        make.top.bottom.equalTo(dynamicTableView);
    }];
    
    ZJContentTableView *moreTableView = [[ZJContentTableView alloc] init];
    moreTableView.delegate            = self;
    moreTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.moreTableView                = moreTableView;
    moreTableView.tableHeaderView     = headView;
    [scrollView addSubview:moreTableView];
    [moreTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(Width * 2);
        make.width.equalTo(dynamicTableView);
        make.top.bottom.equalTo(dynamicTableView);
    }];
    
    ZJContentTableView *moreTableView1 = [[ZJContentTableView alloc] init];
    moreTableView1.delegate            = self;
    moreTableView1.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.moreTableView1                = moreTableView1;
    moreTableView1.tableHeaderView     = headView;
    [scrollView addSubview:moreTableView1];
    [moreTableView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(Width * 3);
        make.width.equalTo(moreTableView);
        make.top.bottom.equalTo(moreTableView);
    }];
}
/// tableView 的头部视图
- (void)setupHeaderView {
    UIView *headerView                     = [[ZJPersonalHomePageHeaderView alloc] init];
    headerView.frame                       = CGRectMake(0, 0, Width, ZJHeadViewHeight + ZJTitleHeight);
    [self.view addSubview:headerView];
    self.headerView                        = headerView;
    ZJPersonalHomePageTitleView *titleView = [[ZJPersonalHomePageTitleView alloc] init];
    [headerView addSubview:titleView];
    self.titleView                         = titleView;
    titleView.backgroundColor              = [UIColor whiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(headerView);
        make.bottom.equalTo(headerView.mas_bottom);
        make.height.mas_equalTo(ZJTitleHeight);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(headerView.top);
    }];
    
    __weak typeof(self) weakSelf = self;
    titleView.titles             = @[@"动态1234", @"文章", @"更多信息嘿",@"klf"];
    titleView.selectedIndex      = 0;
    titleView.buttonSelected     = ^(NSInteger index){
        [weakSelf.scrollView setContentOffset:CGPointMake(Width * index, 0) animated:YES];
    };
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGFloat contentOffsetX       = scrollView.contentOffset.x;
        NSInteger pageNum            = contentOffsetX / Width + 0.5;
        self.titleView.selectedIndex = pageNum;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView || !scrollView.window) {
        return;
    }
    CGFloat offsetY      = scrollView.contentOffset.y;
    CGFloat originY      = 0;
    CGFloat otherOffsetY = 0;
    if (offsetY <= ZJHeadViewHeight) {
        originY              = -offsetY;
        if (offsetY < 0) {
            otherOffsetY         = 0;
        } else {
            otherOffsetY         = offsetY;
        }
    } else {
        originY              = -ZJHeadViewHeight;
        otherOffsetY         = ZJHeadViewHeight;
    }
    self.headerView.frame = CGRectMake(0, originY, Width, ZJHeadViewHeight + ZJTitleHeight);
    for ( int i = 0; i < self.titleView.titles.count; i++ ) {
        if (i != self.titleView.selectedIndex) {
            UITableView *contentView = self.scrollView.subviews[i];
            CGPoint offset = CGPointMake(0, otherOffsetY);
            if ([contentView isKindOfClass:[UITableView class]]) {
                if (contentView.contentOffset.y < ZJHeadViewHeight || offset.y < ZJHeadViewHeight) {
                    [contentView setContentOffset:offset animated:NO];
                    self.scrollView.offset = offset;
                }
            }
        }
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    NSLog(@"控制器已销毁");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
