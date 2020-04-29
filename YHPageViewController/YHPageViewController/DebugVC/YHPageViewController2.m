//
//  YHPageViewController2.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageViewController2.h"

#import "YHColorViewController.h"
#import "YHTableViewController.h"

#import "YHKit.h"

@interface YHPageViewController2 ()

@end

@implementation YHPageViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标签栏是否显示在导航条上方
    self.segmentMenuShowOnNavigationBar = YES;
    
    //添加他的自控制器 和他的标题配置
    [self yh_addChildController:[YHColorViewController new] title:@"标题1"];
    [self yh_addChildController:[YHColorViewController new] title:@"标题2"];
    [self yh_addChildController:[YHColorViewController new] title:@"标题3"];
    [self yh_addChildController:[YHTableViewController new] title:@"标题1111"];
    [self yh_addChildController:[YHTableViewController new] title:@"标题222LLLooonnnnnnngg"];
    [self yh_addChildController:[YHTableViewController new] titleConfig:^(YHPageTitleItem * _Nonnull item) {
        item.title = @"标题333";
    }];
    
    //标签栏上标题字体 间距 布局 指示器 等设置
    self.segmentControl.config.layoutType = YHSegmentLayoutType_Left;
    self.segmentControl.config.progressAnimation = YHSegmentAnimation_LineFadein;
    self.segmentControl.config.fontSelected = [UIFont yh_pfmOfSize:20];
    self.segmentControl.config.fontSelected = [UIFont yh_pfOfSize:16];
    
    //这个需要调用一次
    [self yh_reloadController];
    
    //初始选中位置
    self.selectIndex = 4;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
