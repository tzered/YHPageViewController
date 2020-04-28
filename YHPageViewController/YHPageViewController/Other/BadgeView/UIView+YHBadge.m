//
//  UIView+YHBadge.m
//  MoreCoin
//
//  Created by 林宁宁 on 2019/9/23.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import "UIView+YHBadge.h"
#import "NSMutableAttributedString+YH.h"
#import <objc/runtime.h>
#import "YHKit.h"


@implementation UIView (YHBadge)

-(YHBadgeCountView *)badgeCountV{
    YHBadgeCountView * badgeV = objc_getAssociatedObject(self, @selector(badgeCountV));
    if(!badgeV){
        badgeV = [YHBadgeCountView new];
        badgeV.pos = YHBadgeCountPos_rightTop;
        badgeV.centerOffet = CGPointMake(Adapted(9), Adapted(-10));
        badgeV.backgroundColor = [UIColor yh_red_dark];
        badgeV.layer.masksToBounds = YES;
        
        badgeV.layer.cornerRadius = 2;
        badgeV.lab.textColor = [UIColor whiteColor];
        badgeV.lab.font = [UIFont yh_pfOfSize:13];
        
        badgeV.badgeHeight = Adapted(6);
        
        if(self.superview){
            badgeV.centerOffetV = self;
            [self.superview addSubview:badgeV];
        }else{
            [self addSubview:badgeV];
        }
        
        self.badgeCountV = badgeV;
    }
    return badgeV;
}

-(void)setBadgeCountV:(YHBadgeCountView *)badgeCountV{
    objc_setAssociatedObject(self, @selector(badgeCountV), badgeCountV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



-(YHBadgeCountView *)badgePointV{
    YHBadgeCountView * badgeV = objc_getAssociatedObject(self, @selector(badgePointV));
    if(!badgeV){
        badgeV = [YHBadgeCountView new];
        badgeV.pos = YHBadgeCountPos_rightTop;
        badgeV.centerOffet = CGPointMake(Adapted(6), Adapted(-6));
        badgeV.backgroundColor = [UIColor yh_red_dark];
        badgeV.layer.masksToBounds = YES;
        
        badgeV.layer.cornerRadius = 2;
        badgeV.lab.textColor = [UIColor whiteColor];
        badgeV.lab.font = [UIFont yh_pfOfSize:11];
        
        badgeV.badgeHeight = Adapted(6);
        badgeV.isPointShow = NO;
        
        if(self.superview){
            badgeV.centerOffetV = self;
            [self.superview addSubview:badgeV];
        }else{
            [self addSubview:badgeV];
        }
        
        self.badgePointV = badgeV;
    }
    return badgeV;
}

-(void)setBadgePointV:(YHBadgeCountView *)badgePointV{
    objc_setAssociatedObject(self, @selector(badgePointV), badgePointV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end







@implementation YHBadgeCountView


-(void)yh_commonInit{
    
    self.badgeHeight = Adapted(16);
    
    self.lab = [UILabel new];
    self.lab.textAlignment = NSTextAlignmentCenter;
    self.lab.textColor = [UIColor whiteColor];
    self.lab.backgroundColor = [UIColor clearColor];
    
    self.lab.font = [UIFont yh_pfOfSize:10];
    [self addSubview:self.lab];
    
    self.backgroundColor = [UIColor yh_red_dark];
    self.layer.cornerRadius = self.badgeHeight*0.5;
    self.layer.masksToBounds = YES;
//    self.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.layer.borderWidth = 1;
    
    self.userInteractionEnabled = NO;
    self.hidden = YES;
}


-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    if(!self.superview ||
       !CGRectIsEmpty(self.frame)){
        return;
    }
    
    [self updateFrameShow];
    
}

- (void)setCenterOffetV:(UIView *)centerOffetV{
    _centerOffetV = centerOffetV;
    
    
    if(!self.superview || !centerOffetV){
        return;
    }
    centerOffetV.clipsToBounds = NO;
    [self updateFrameShow];
}

-(void)setCenterOffet:(CGPoint)centerOffet{
    _centerOffet = centerOffet;
    if(!self.superview){
        return;
    }
    [self updateFrameShow];
}


-(void)setBadgeCount:(NSString *)badgeCount{
    
    _badgeCount = badgeCount;
    
    if(!badgeCount || [badgeCount isEqualToString:@""]){
        self.hidden = YES;
    }else{
        self.hidden = NO;
        
        if([self isPureInt:badgeCount]){
            if([badgeCount integerValue] == 0 && !self.isShowZero){
                self.hidden = YES;
                return;
            }
            
            if([badgeCount integerValue] > 99){
                badgeCount = @"99+";
            }
        }
        self.badgeHeight = MAX(Adapted(16), self.badgeHeight);
        self.lab.text = badgeCount;
        [self updateFrameShow];
    }
}

-(void)setIsPointShow:(BOOL)isPointShow{
    _isPointShow = isPointShow;
    
    self.hidden = !isPointShow;
    
    self.layer.cornerRadius = self.badgeHeight*0.5;
    self.lab.text = @"";
    if(self.superview){
        [self updateFrameShow];
    }
    
}

-(void)setBadgeHeight:(CGFloat)badgeHeight{
    _badgeHeight = badgeHeight;
    
    
    self.layer.cornerRadius = badgeHeight*0.5;
    
    [self updateFrameShow];
    
}


- (void)updateFrameShow{
    if(!self.superview){
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGRect oldFrame = self.frame;
        
        oldFrame.size = CGSizeMake(self.badgeHeight, self.badgeHeight);
        
        CGFloat offsetX = self.centerOffet.x ;
        CGFloat offsetY = self.centerOffet.y;
        
        if(self.pos == YHBadgeCountPos_Defalut){
            offsetX = offsetX - self.badgeHeight;
            offsetY = offsetY - self.badgeHeight;
            if(self.centerOffetV){
                oldFrame.origin.x = CGRectGetMidX(self.centerOffetV.frame)+offsetX;
                oldFrame.origin.y = CGRectGetMinY(self.centerOffetV.frame)+offsetY;
                
            }else{
                oldFrame.origin.x = CGRectGetMidX(self.superview.frame)+offsetX;
                oldFrame.origin.y = CGRectGetMinY(self.superview.frame)+offsetY;
            }
        }else if(self.pos == YHBadgeCountPos_rightCentetY){
            offsetX = offsetX - self.badgeHeight;
            offsetY = offsetY - self.badgeHeight;
            if(self.centerOffetV){
                oldFrame.origin.x = CGRectGetMaxX(self.centerOffetV.frame)+offsetX;
                oldFrame.origin.y = CGRectGetMidY(self.centerOffetV.frame)+offsetY;
            }else{
                oldFrame.origin.x = CGRectGetMaxX(self.superview.frame)+offsetX;
                oldFrame.origin.y = CGRectGetMidY(self.superview.frame)+offsetY;
            }
        }else if(self.pos == YHBadgeCountPos_rightTop){
            offsetX = offsetX - self.badgeHeight;
            
            if(self.centerOffetV){
                oldFrame.origin.x = CGRectGetMaxX(self.centerOffetV.frame)+offsetX;
                oldFrame.origin.y = CGRectGetMinY(self.centerOffetV.frame)+offsetY;
            }else{
                oldFrame.origin.x = CGRectGetMaxX(self.superview.frame)+offsetX;
                oldFrame.origin.y = CGRectGetMinY(self.superview.frame)+offsetY;
            }
        }else if (self.pos == YHBadgeCountPos_outSetting){
            //不设置
            
        }else if (self.pos == YHBadgeCountPos_rightBottom){
            offsetX = offsetX - self.badgeHeight;
            offsetY = offsetY - self.badgeHeight;
            if(self.centerOffetV){
                oldFrame.origin.x = CGRectGetMaxX(self.centerOffetV.frame)+offsetX;
                
                oldFrame.origin.y = CGRectGetMaxY(self.centerOffetV.frame)+offsetY;
            }else{
                oldFrame.origin.x = CGRectGetMaxX(self.superview.frame)+offsetX;
                oldFrame.origin.y = CGRectGetMaxY(self.superview.frame)+offsetY;
            }
        }
        
        if(!self.isPointShow){
            if(self.lab && self.lab.attributedText){
                NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.lab.attributedText];
                CGSize sizeStr = [attStr yh_getSizeConstrainedToSize:CGSizeMake(FLT_MAX, self.badgeHeight)];
                oldFrame.size.width = MAX(sizeStr.width + Adapted(8), oldFrame.size.width);
            }
            
            oldFrame.size = CGSizeMake(MAX(self.badgeHeight, oldFrame.size.width), self.badgeHeight);
        }
        
        self.frame = oldFrame;
        
        self.lab.frame = self.bounds;
    });
}

- (BOOL)isPureInt:(NSString *)str{
    NSScanner* scan = [NSScanner scannerWithString:str];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
