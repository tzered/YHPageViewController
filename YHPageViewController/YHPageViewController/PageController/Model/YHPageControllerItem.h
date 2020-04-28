//
//  YHPageControllerItem.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"
#import "YHPageTitleItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface YHPageControllerItem : YHBaseObject

@property (retain, nonatomic) UIViewController * showViewController;

@property (assign, nonatomic) NSInteger index;

@property (retain, nonatomic) YHPageTitleItem * titleInfo;

@end



NS_ASSUME_NONNULL_END
