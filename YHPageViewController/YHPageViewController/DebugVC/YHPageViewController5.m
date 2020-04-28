//
//  YHPageViewController5.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageViewController5.h"

#import "YHColorViewController.h"
#import "YHTableViewController.h"

#import "UIFont+YH.h"
#import <Masonry.h>

@interface YHPageViewController5 ()

@end

@implementation YHPageViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(&*self)weakSelf = self;
    
    NSMutableArray * dataList = [NSMutableArray new];
    YHPageTitleItem * item = [YHPageTitleItem new];
    item.title = @"布局靠左";
    [dataList addObject:item];

    item = [YHPageTitleItem new];
    item.title = @"布局居中";
    [dataList addObject:item];

    item = [YHPageTitleItem new];
    item.title = @"布局靠右";
    [dataList addObject:item];

    YHSegmentView * segmentView1 = [YHSegmentView new];
    [segmentView1 resetSegmentTitles:dataList];
    [segmentView1 setSelectBlock:^(NSInteger passIndex) {
        
        if(passIndex == 0){
            weakSelf.segmentControl.config.layoutType = YHSegmentLayoutType_Left;
        }else if (passIndex == 1){
            weakSelf.segmentControl.config.layoutType = YHSegmentLayoutType_Center;
        }else if (passIndex == 2){
            weakSelf.segmentControl.config.layoutType = YHSegmentLayoutType_Right;
        }
        
        [weakSelf yh_reloadSegmentMenu];
    }];
    [self.view addSubview:segmentView1];
    [segmentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    
    
    dataList = [NSMutableArray new];
    item = [YHPageTitleItem new];
    item.title = @"指示器无";
    [dataList addObject:item];

    item = [YHPageTitleItem new];
    item.title = @"指示器线条";
    [dataList addObject:item];
    
    item = [YHPageTitleItem new];
    item.title = @"指示器线条等宽";
    [dataList addObject:item];

    item = [YHPageTitleItem new];
    item.title = @"指示器描边";
    [dataList addObject:item];
    
    YHSegmentView * segmentView2 = [YHSegmentView new];
    [segmentView2 resetSegmentTitles:dataList];
    [segmentView2 setSelectBlock:^(NSInteger passIndex) {
        
        YHSegmentConfig * config = weakSelf.segmentControl.config;
        
        if(passIndex == 0){
            config.indicatorType = YHIndicatorType_None;
        }else if (passIndex == 1){
            config.indicatorType = YHIndicatorType_Line;
            config.indicatorSize = CGSizeMake(30, 2);
        }else if (passIndex == 2){
            config.indicatorType = YHIndicatorType_Line;
            config.indicatorSize = CGSizeZero;
        }else if (passIndex == 3){
            config.indicatorType = YHIndicatorType_Border;
            config.borderColorNormal = [UIColor systemGray2Color];
            config.borderColorSelect = [UIColor systemBlueColor];
            config.borderWidthNormal = 0.5;
            config.borderWidthSelect = 1.5;
            config.spaceItemInside = 20;
            config.spaceItem = 12;
            config.spaceContentLeft = 16;
            config.spaceContentRight = 16;
            config.spaceContentTop = 10;
            config.spaceContentBottom = 10;
        }
        
        [weakSelf yh_reloadSegmentMenu];
    }];
    [self.view addSubview:segmentView2];
    [segmentView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(segmentView1.mas_top);
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    [self yh_addChildController:[YHColorViewController new] title:@"标题1"];
    [self yh_addChildController:[YHTableViewController new] title:@"标题22"];
    [self yh_addChildController:[YHColorViewController new] title:@"标题333"];


    self.segmentControl.config.layoutType = YHSegmentLayoutType_Left;

    self.segmentControl.config.fontSelected = [UIFont yh_pfmOfSize:22];
    self.segmentControl.config.fontNormal = [UIFont yh_pfOfSize:15];

    self.frameForMenuView = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60);
    self.frameForContentView =
    CGRectMake(0,
               CGRectGetMaxY(self.frameForMenuView),
               CGRectGetWidth(self.view.frame),
               CGRectGetHeight(self.view.frame) -
                CGRectGetMaxY(self.frameForMenuView) -
                50 - 50);
    
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
