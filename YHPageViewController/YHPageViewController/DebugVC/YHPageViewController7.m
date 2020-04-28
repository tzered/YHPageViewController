//
//  YHPageViewController7.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageViewController7.h"


#import "YHColorViewController.h"
#import "YHTableViewController.h"

#import "YHPageViewController1.h"
#import "YHPageViewController6.h"


@interface YHPageViewController7 ()

@end

@implementation YHPageViewController7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.segmentMenuShowOnNavigationBar = YES;
    
    [self yh_addChildController:[YHPageViewController1 new] title:@"标题1"];
    [self yh_addChildController:[YHColorViewController new] title:@"标题2"];
    [self yh_addChildController:[YHPageViewController6 new] title:@"标题3"];
    
    
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
