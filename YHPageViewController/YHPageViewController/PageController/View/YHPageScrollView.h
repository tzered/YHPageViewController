//
//  YHPageScrollView.h
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHPageScrollView : UIScrollView

/// 最大滚动距离
/// 小于这个距离 当前这个scrollview可以滚动  其他的scrolview 的contentoffset 为0  不能滚动
/// 大于 当前的scrollview不能滚动 固定这个offer 其他的scrollview可以滚动
@property (assign, nonatomic) CGFloat maxOffsetY;

/// 滚动回调
@property (copy, nonatomic) void(^didScrollBlock)(CGFloat offy);

@end

NS_ASSUME_NONNULL_END
