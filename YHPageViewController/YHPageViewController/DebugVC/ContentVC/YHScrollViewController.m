//
//  YHScrollViewController.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHScrollViewController.h"
#import "YHKit.h"

@interface YHScrollViewController ()

@property (retain, nonatomic) UIScrollView * scrollView;

@end

@implementation YHScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
        
    for(NSInteger i = 0; i<20; i++){
        UIView * subV = [self createLab];
        [self.scrollView addSubview:subV];
    }
    
    [self.scrollView.subviews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:50 leadSpacing:50 tailSpacing:50];
    [self.scrollView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
}

- (UILabel *)createLab{
    
    UILabel * lab = [UILabel new];
    lab.backgroundColor = [UIColor yh_randomcolor];
    lab.text = [NSString stringWithFormat:@"\n%@\n",@(arc4random()%10000+1000).stringValue];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    lab.font = [UIFont yh_pfmOfSize:30];
    lab.textColor = [UIColor whiteColor];

    return lab;
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
