//
//  YHConstant.h
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 多尺寸适配比例 以4.7寸为效果*/
extern CGFloat Adapted(CGFloat value);
/** 多尺寸适配比例 以4.7寸为效果*/
extern CGFloat AdaptedHeight(CGFloat value);


BOOL IsNull(id obj);
BOOL IsNonNull(id obj);


//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


NS_ASSUME_NONNULL_BEGIN

@interface YHConstant : NSObject

@end

NS_ASSUME_NONNULL_END
