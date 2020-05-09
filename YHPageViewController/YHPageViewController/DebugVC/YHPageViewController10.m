//
//  YHPageViewController10.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/5/9.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageViewController10.h"


#import "YHColorViewController.h"
#import "YHTableViewController.h"
#import "YHScrollViewController.h"

#import "YHKit.h"
#import "MJRefresh.h"


@interface YHHeaderView10 : YHBaseView

@end

@implementation YHHeaderView10

-(void)yh_commonInit{
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor yh_gradientFromcolor:[UIColor blueColor] toColor:[[UIColor blueColor] colorWithAlphaComponent:0.2] withHeight:CGRectGetHeight(self.frame)];
}

@end


@interface YHPageViewController10 ()

@property (retain, nonatomic) YHHeaderView10 * headV;

@end

@implementation YHPageViewController10


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.pageViewController yh_addChildController:[YHTableViewController new] title:@"TableView"];
    [self.pageViewController yh_addChildController:[YHColorViewController new] title:@"标题2"];
    [self.pageViewController yh_addChildController:[YHScrollViewController new] title:@"Scrollview"];
        
    [self.pageViewController yh_reloadController];
    
    [self setHeaderScrollBlock:^(CGFloat offy) {
   
    }];
    
    WS(weakSelf)
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshEvent];
    }];
}

- (void)refreshEvent{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scrollView.mj_header endRefreshing];
    });
}

-(YHHeaderView10 *)headV{
    if(_headV){
        return _headV;
    }
    YHHeaderView10 * headV = [YHHeaderView10 new];
    _headV = headV;
    return _headV;
}

-(UIView *)yh_pageHeaderView{
    return self.headV;
}

-(CGFloat)yh_pageHeaderHeight{
    return 150;
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
