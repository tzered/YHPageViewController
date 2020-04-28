//
//  UIScrollView+OffsetNotifition.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/23.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//extern NSNotificationName MCScrollViewOffsetChangeNotifition;

@interface UIScrollView (OffsetNotifition)

@property (copy, nonatomic) void(^contentOffsetBlock)(CGPoint offset, UIScrollView * scrollView);

@property (copy, nonatomic) CGPoint (^contentOffsetResetBlock)(CGPoint offset, UIScrollView * scrollView);

@end

NS_ASSUME_NONNULL_END
