//
//  YHSegmentView.h
//  MoreCoin
//
//  Created by 林宁宁 on 2019/11/4.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import "YHBaseView.h"
#import "YHPageTitleItem.h"

NS_ASSUME_NONNULL_BEGIN

/// 指示器e类型
typedef NS_ENUM(NSInteger, YHIndicatorType) {
    YHIndicatorType_None,
    YHIndicatorType_Line,
    YHIndicatorType_Border,//描边
};

/// 标题布局方式
typedef NS_ENUM(NSInteger, YHSegmentLayoutType) {
    YHSegmentLayoutType_Left,
    //如果内容超过父视图大小 模式 做布局
    YHSegmentLayoutType_Center,
    YHSegmentLayoutType_Right
};

@class YHSegmentConfig;
@interface YHSegmentView : YHBaseView

@property (assign, nonatomic) NSInteger selectIndex;

@property (retain, nonatomic) YHSegmentConfig * config;

@property (assign, nonatomic, readonly) NSInteger segmentCount;

@property (copy, nonatomic) void(^selectBlock)(NSInteger passIndex);


- (void)resetSegmentTitles:(NSArray <YHPageTitleItem *>*)segTitles;

- (UIButton *)getItemViewAtIndex:(NSInteger)index;

@end


@interface YHSegmentConfig : YHBaseObject

@property (nonatomic, retain) UIFont * fontSelected;
@property (nonatomic, retain) UIFont * fontNormal;
@property (nonatomic, strong) UIColor * colorSelected;
@property (nonatomic, strong) UIColor * colorNormal;

/// 布局方式
@property (nonatomic, assign) YHSegmentLayoutType layoutType;
/// 指示器类型
@property (nonatomic, assign) YHIndicatorType indicatorType;

@property (nonatomic, assign) CGFloat miniItemWidth;
@property (nonatomic, assign) CGFloat spaceItem;
@property (nonatomic, assign) CGFloat spaceItemInside;//按钮内部左右间距

@property (nonatomic, assign) CGFloat spaceContentLeft;
@property (nonatomic, assign) CGFloat spaceContentRight;
@property (nonatomic, assign) CGFloat spaceContentTop;
@property (nonatomic, assign) CGFloat spaceContentBottom;

/// 为空跟标题同宽 否则为设置的固定值
@property (nonatomic, assign) CGSize indicatorSize;

/// 线条的指示器调整
@property (nonatomic, assign) CGFloat indicatorLineBottomOffset;


/// indicatorType 布局方式是 YHIndicatorType_Border 下的设置
@property (nonatomic, strong) UIColor * borderColorNormal;
@property (nonatomic, strong) UIColor * borderColorSelect;
@property (nonatomic, assign) CGFloat borderWidthNormal;
@property (nonatomic, assign) CGFloat borderWidthSelect;
@property (nonatomic, assign) CGFloat cornerRadius;

@end


NS_ASSUME_NONNULL_END
