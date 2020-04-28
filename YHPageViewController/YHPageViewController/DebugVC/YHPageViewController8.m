//
//  YHPageViewController8.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageViewController8.h"

#import "YHColorViewController.h"
#import "YHTableViewController.h"
#import "YHScrollViewController.h"

#import "YHKit.h"

@interface YHHeaderView : YHBaseView

@end

@implementation YHHeaderView

-(void)yh_commonInit{
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor yh_gradientFromcolor:[UIColor orangeColor] toColor:[[UIColor blueColor] colorWithAlphaComponent:0.2] withHeight:CGRectGetHeight(self.frame)];
}

@end



@interface YHPageViewController8 ()

@property (retain, nonatomic) YHHeaderView * headV;

@end

@implementation YHPageViewController8

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
}

-(YHHeaderView *)headV{
    if(_headV){
        return _headV;
    }
    YHHeaderView * headV = [YHHeaderView new];
    _headV = headV;
    return _headV;
}

-(UIView *)yh_pageHeaderView{
    return self.headV;
}

-(CGFloat)yh_pageHeaderHeight{
    return 250;
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
