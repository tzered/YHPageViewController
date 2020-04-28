//
//  YHPageViewController4.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageViewController4.h"

#import "YHColorViewController.h"
#import "YHTableViewController.h"

#import "UIView+YHBadge.h"

@interface YHPageViewController4 ()

@end

@implementation YHPageViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self yh_addChildController:[YHColorViewController new] title:@"标题1"];
    [self yh_addChildController:[YHColorViewController new] title:@"标题2"];
    [self yh_addChildController:[YHColorViewController new] title:@"标题3"];
    
    [self yh_addChildController:[YHTableViewController new] title:@"标题1111"];
    [self yh_addChildController:[YHTableViewController new] title:@"标题222LLLooonnnnnnngg"];
    [self yh_addChildController:[YHTableViewController new] title:@"标题333"];
    
    self.canPanPopBackWhenAtFirstPage = YES;
    
    [self setBadgeCountIndexBlock:^(NSInteger index, UIButton * _Nonnull badgeView) {
        NSArray * counts = @[@"1",@"23",@"",@"",@"9999",@"23",@"",@""];
        badgeView.titleLabel.badgeCountV.badgeCount = counts[index];
    }];
    

    
    
    [self yh_reloadController];
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
