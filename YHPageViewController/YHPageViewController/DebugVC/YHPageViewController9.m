//
//  YHPageViewController9.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageViewController9.h"


#import "YHColorViewController.h"
#import "YHTableViewController.h"
#import "YHScrollViewController.h"
#import "YHPageViewController6.h"

#import "UIFont+YH.h"
#import <Masonry.h>
#import "UIButton+Block.h"

@interface YHPageViewController9 ()

@property (assign, nonatomic) YHSegmentAnimation animation;

@property (retain, nonatomic) YHPageViewController6 * pageVC6;

@end

@implementation YHPageViewController9

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(&*self)weakSelf = self;
    
    UIView * btnViews = [UIView new];
    btnViews.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnViews];
    [btnViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    NSArray * titls = @[@"指示器",@"字体",@"颜色"];
    for(NSInteger i = 0; i < titls.count; i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor systemGray6Color];
        [btn setTitle:titls[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        if (i == 0){
            btn.tag = YHSegmentAnimation_LineFadein;
        }else if (i == 1){
            btn.tag = YHSegmentAnimation_FontSize;
        }else if (i == 2){
            btn.tag = YHSegmentAnimation_TextColor;
        }
//        else if (i == 3){
//            btn.tag = YHSegmentAnimation_WaterDrop;
//        }
        
        [btnViews addSubview:btn];
        [btn addActionHandler:^(UIButton * sender,NSInteger tag) {
            
            sender.selected = !sender.selected;
            
            YHSegmentAnimation animation = YHSegmentAnimation_None;
            for(UIButton * sbtn in btnViews.subviews){
                if(sbtn.selected){
                    animation = animation|sbtn.tag;
                }
            }
            weakSelf.segmentControl.config.progressAnimation = animation;
            weakSelf.pageVC6.segmentControl.config.progressAnimation = animation;
        }];
    }
    [btnViews.subviews mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [btnViews.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnViews);
    }];
    
    
    self.pageVC6 = [YHPageViewController6 new];
    
    
    [self yh_addChildController:[YHColorViewController new] title:@"标题1"];
    [self yh_addChildController:self.pageVC6 title:@"PageVC6"];
    [self yh_addChildController:[YHColorViewController new] title:@"短"];
    [self yh_addChildController:[YHTableViewController new] title:@"大海尽头"];
    [self yh_addChildController:[YHScrollViewController new] title:@"标签栏切换动画效果展示"];


    self.segmentControl.config.layoutType = YHSegmentLayoutType_Left;
    self.segmentControl.config.indicatorLineCornerRadius = self.segmentControl.config.indicatorSize.height*0.5;
    
    self.segmentControl.config.fontSelected = [UIFont yh_pfmOfSize:22];
    self.segmentControl.config.fontNormal = [UIFont yh_pfOfSize:15];

    self.frameForMenuView = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60);
    self.frameForContentView =
    CGRectMake(0,
               CGRectGetMaxY(self.frameForMenuView),
               CGRectGetWidth(self.view.frame),
               CGRectGetHeight(self.view.frame) -
                CGRectGetMaxY(self.frameForMenuView) -
                80);
    
    [self yh_reloadController];
    
}


@end
