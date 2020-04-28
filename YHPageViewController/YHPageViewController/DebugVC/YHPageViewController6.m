//
//  YHPageViewController6.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPageViewController6.h"

#import "YHColorViewController.h"
#import "YHTableViewController.h"

#import "NSMutableAttributedString+YH.h"

#import "UIFont+YH.h"
#import "UIColor+YHStyle.h"

@interface YHPageViewController6 ()

@end

@implementation YHPageViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self yh_addChildController:[YHColorViewController new] titleConfig:^(YHPageTitleItem * _Nonnull item) {
        item.titleShowType = YHPageTitleShowType_Title;
        item.title = @"标题1";
    }];
    [self yh_addChildController:[YHTableViewController new] titleConfig:^(YHPageTitleItem * _Nonnull item) {
        item.titleShowType = YHPageTitleShowType_Image;
        item.imageNormal = [UIImage systemImageNamed:@"hare"];
        item.imageSelect = [UIImage systemImageNamed:@"hare.fill"];
    }];
    [self yh_addChildController:[YHColorViewController new] titleConfig:^(YHPageTitleItem * _Nonnull item) {
        item.titleShowType = YHPageTitleShowType_TitleAndImage;
        item.title = @"heart";
        item.imageNormal = [UIImage systemImageNamed:@"heart"];
        item.imageSelect = [UIImage systemImageNamed:@"heart.fill"];
    }];
    [self yh_addChildController:[YHTableViewController new] titleConfig:^(YHPageTitleItem * _Nonnull item) {
        item.titleShowType = YHPageTitleShowType_Attribute;
        item.attStringNormal = [NSMutableAttributedString yh_initWithStr:@" Attribue0" customBlock:^(NSMutableAttributedString *att) {
            [att yh_font:[UIFont yh_pfmOfSize:15]];
            [att yh_color:[UIColor yh_title_h3_note]];
            
            [att yh_attachImage:[UIImage systemImageNamed:@"play"] imageSize:CGSizeMake(15, 15) atIndex:0];
        }];
        item.attStringSelect = [NSMutableAttributedString yh_initWithStr:@" Attribue1" customBlock:^(NSMutableAttributedString *att) {
            [att yh_font:[UIFont yh_pfmOfSize:16]];
            [att yh_color:[UIColor yh_blue]];
            
            [att yh_attachImage:[UIImage systemImageNamed:@"play.fill"] imageSize:CGSizeMake(15, 15) atIndex:0];
        }];
    }];
    

    self.segmentControl.config.indicatorType = YHIndicatorType_Border;
    self.segmentControl.config.spaceContentTop = 10;
    self.segmentControl.config.spaceContentBottom = 10;
    self.segmentControl.config.cornerRadius = 6;
    self.frameForMenuView = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 70);
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
