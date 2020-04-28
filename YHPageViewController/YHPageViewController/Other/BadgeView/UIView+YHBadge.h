//
//  UIView+YHBadge.h
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/23.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YHBadgeCountPos) {
    YHBadgeCountPos_Defalut,//视图顶部居中靠右
    YHBadgeCountPos_rightCentetY,//右侧 居中
    YHBadgeCountPos_rightTop,//右侧 上边
    YHBadgeCountPos_rightBottom,//右侧 下边
    YHBadgeCountPos_outSetting,//外部设置 x y 坐标
};

@class YHBadgeCountView;
@interface UIView (YHBadge)


/// 角标数
@property (retain, nonatomic) YHBadgeCountView * badgeCountV;
/// 红点
@property (retain, nonatomic) YHBadgeCountView * badgePointV;

@end





/** 角标视图
 默认
 中心点 x 跟父视图右边对齐
 中心点 y 跟父视图上边对齐
 */
@interface YHBadgeCountView : YHBaseView

/** 相对的中心点偏移视图*/
@property (weak, nonatomic) UIView * centerOffetV;
/** 相对的中心点偏移视图*/
@property (assign, nonatomic) CGPoint centerOffet;

@property (assign, nonatomic) YHBadgeCountPos pos;

/** 高度 默认12*/
@property (assign, nonatomic) CGFloat badgeHeight;

@property (retain, nonatomic) UILabel * lab;
@property (copy, nonatomic) NSString * _Nullable badgeCount; //角标数
@property (assign, nonatomic) BOOL isPointShow; //显示小红点
@property (assign, nonatomic) BOOL isShowZero;  //角标数为0 也显示

@end



NS_ASSUME_NONNULL_END
