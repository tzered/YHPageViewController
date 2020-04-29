//
//  YHPageTitleItem.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"

/// 标题显示类型
typedef NS_ENUM(NSInteger, YHPageTitleShowType) {
    YHPageTitleShowType_Title,
    YHPageTitleShowType_Image,
    YHPageTitleShowType_Attribute,
    YHPageTitleShowType_TitleAndImage,
};


NS_ASSUME_NONNULL_BEGIN

@interface YHPageTitleItem : YHBaseObject


@property (assign, nonatomic) YHPageTitleShowType titleShowType;

/// 该选项附加的类型信息
@property (assign, nonatomic) NSInteger appendType;

@property (copy, nonatomic) NSString * title;

@property (retain, nonatomic) UIImage * imageNormal;
@property (retain, nonatomic) UIImage * imageSelect;

@property (retain, nonatomic) NSAttributedString * attStringNormal;
@property (retain, nonatomic) NSAttributedString * attStringSelect;

@end

NS_ASSUME_NONNULL_END
