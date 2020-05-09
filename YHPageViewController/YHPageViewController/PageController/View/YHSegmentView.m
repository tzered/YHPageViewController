//
//  YHSegmentView.m
//  MoreCoin
//
//  Created by 林宁宁 on 2019/11/4.
//  Copyright © 2019 MoreCoin. All rights reserved.
//

#import "YHSegmentView.h"
#import "NSMutableAttributedString+YH.h"
#import "YHKit.h"
#import "UIButton+Block.h"
#import "UIView+Frame.h"

@interface YHSegmentView()

@property (retain, nonatomic) UIScrollView * contentView;

/// 指示器视图
@property (retain, nonatomic) UIView * indicatorView;

/// 标题
@property (retain, nonatomic) NSMutableArray <YHPageTitleItem *> * dataList;

@property (retain, nonatomic) NSMutableArray <UIButton *> * btnList;


@end

@implementation YHSegmentView

-(void)yh_commonInit{
    
    self.config = [YHSegmentConfig new];
    self.dataList = [NSMutableArray new];
    self.btnList = [NSMutableArray new];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentView = [UIScrollView new];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.contentView];
    
}

- (UIView *)indicatorView{
    if(!_indicatorView){
        _indicatorView = [UIView new];
        _indicatorView.userInteractionEnabled = NO;
    }
    if(!_indicatorView.superview){
        [self.contentView addSubview:_indicatorView];
    }
    _indicatorView.layer.cornerRadius = self.config.indicatorLineCornerRadius;
    return _indicatorView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
        
    self.contentView.frame = self.bounds;
    [self relayoutContentView];
    
    self.indicatorView.backgroundColor = self.config.colorSelected;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateIndicatorViewAnimation:NO];
    });
}

- (void)resetSegmentTitles:(NSArray <YHPageTitleItem *>*)segTitles{
        
    [self.dataList removeAllObjects];
    [self.btnList removeAllObjects];
    
    for(YHPageTitleItem * titleConfig in segTitles){
        [self addSegmentTitle:titleConfig];
    }
    
    if(self.currentSelectIndex != 0 &&
       self.currentSelectIndex < self.dataList.count){
        self.currentSelectIndex = self.currentSelectIndex;
    }else{
        self.currentSelectIndex = 0;
    }

    if(self.selectBlock){
        self.selectBlock(self.currentSelectIndex);
    }
    
    [self layoutSubviews];
}

- (UIButton *)getItemViewAtIndex:(NSInteger)index{
    if(index < self.btnList.count){
        return self.btnList[index];
    }
    return nil;
}

- (NSInteger)segmentCount{
    return self.btnList.count;
}

-(void)addSegmentTitle:(YHPageTitleItem *)titleConfig{
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.btnList removeAllObjects];
    
    [self.dataList addObject:titleConfig];
    
    WS(weakSelf);
    for(YHPageTitleItem * item in self.dataList){
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        switch (item.titleShowType) {
            case YHPageTitleShowType_Title:{
                [btn setTitle:item.title forState:UIControlStateNormal];
            }
                break;
            case YHPageTitleShowType_Image:{
                [btn setImage:item.imageNormal forState:UIControlStateNormal];
                if(item.imageSelect){
                    [btn setImage:item.imageSelect forState:UIControlStateSelected];
                }
            }
                break;
            case YHPageTitleShowType_TitleAndImage:{
                [btn setTitle:item.title forState:UIControlStateNormal];
                [btn setImage:item.imageNormal forState:UIControlStateNormal];
                if(item.imageSelect){
                    [btn setImage:item.imageSelect forState:UIControlStateSelected];
                }
            }
                break;
            case YHPageTitleShowType_Attribute:{
                [btn setAttributedTitle:item.attStringNormal forState:UIControlStateNormal];
                if(item.attStringSelect){
                    [btn setAttributedTitle:item.attStringSelect forState:UIControlStateSelected];
                }
            }
                break;
                
            default:
                break;
        }
        
        btn.tag = [self.dataList indexOfObject:item];
        [btn addActionHandler:^(UIButton * sender,NSInteger tag) {
            
            if(weakSelf.currentSelectIndex == tag){
                return;
            }
            weakSelf.currentSelectIndex = tag;
            
            if(weakSelf.selectBlock){
                weakSelf.selectBlock(weakSelf.currentSelectIndex);
            }
        }];
        [self.contentView addSubview:btn];
        [self.btnList addObject:btn];
    }
    
    [self relayoutContentView];
}

- (void)relayoutContentView{
    
    if(CGRectIsEmpty(self.contentView.frame)){
        return;
    }
    
    CGFloat contentWidth = 0;
    for(NSInteger i = 0; i < self.dataList.count; i++){
        YHPageTitleItem * item = self.dataList[i];
        UIButton * btn = self.btnList[i];
        
        if(self.currentSelectIndex == i){
            btn.titleLabel.font = self.config.fontSelected;
            [btn setTitleColor:self.config.colorSelected forState:UIControlStateNormal];
        }else{
            btn.titleLabel.font = self.config.fontNormal;
            [btn setTitleColor:self.config.colorNormal forState:UIControlStateNormal];
        }
        
        btn.width = [self getItemViewWidthByTitle:item index:i];
        btn.height = self.height - self.config.spaceContentTop - self.config.spaceContentBottom;
        btn.y = self.config.spaceContentTop;
        
        contentWidth = contentWidth + btn.width;
        if(i != self.dataList.count - 1){
            contentWidth = contentWidth + self.config.spaceItem;
        }
    }
    contentWidth = contentWidth + self.config.spaceContentRight + self.config.spaceContentLeft;
    
    CGFloat originX = 0;
    
    switch (self.config.layoutType) {
        case YHSegmentLayoutType_Right:{
            if(contentWidth < self.width){
                originX = self.width - contentWidth + self.config.spaceContentLeft;
            }else{
                //超过父视图 宽度 转左边开始布局
                originX = self.config.spaceContentLeft;
            }
        }
            break;
        case YHSegmentLayoutType_Center:{
            if(contentWidth < self.width){
                //设置居中布局
                originX = (self.width - contentWidth)*0.5 + self.config.spaceContentLeft;
            }else{
                //超过父视图 宽度 转左边开始布局
                originX = self.config.spaceContentLeft;
            }
        }
            break;
        case YHSegmentLayoutType_Left:{
            originX = self.config.spaceContentLeft;
        }
            break;
        default:
            originX = self.config.spaceContentLeft;
            break;
    }
    
    for(UIButton * btn in self.btnList){
        btn.x = originX;
        originX = originX + btn.width + self.config.spaceItem;
    }
    self.contentView.contentSize = CGSizeMake(MAX(contentWidth, self.width), self.height);
    
}

- (CGFloat)getItemViewWidthByTitle:(YHPageTitleItem *)item index:(NSInteger)index{
    
    CGFloat itemWidth;
    
    switch (item.titleShowType) {
        case YHPageTitleShowType_Title:{
            UIFont *titleFont = self.config.fontNormal;
            if(self.currentSelectIndex == index){
                titleFont = self.config.fontSelected;
            }
            NSDictionary *attrs = @{NSFontAttributeName: titleFont};
            itemWidth = [item.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil].size.width;
        }
            break;
        case YHPageTitleShowType_Image:{
            itemWidth = item.imageNormal.size.width*self.height/item.imageNormal.size.height;
            itemWidth = MIN(itemWidth, item.imageNormal.size.width);
            if(self.currentSelectIndex == index && item.imageSelect){
                itemWidth = item.imageSelect.size.width*self.height/item.imageSelect.size.height;
                itemWidth = MIN(itemWidth, item.imageSelect.size.width);
            }
        }
            break;
        case YHPageTitleShowType_TitleAndImage:{
            UIFont *titleFont = self.config.fontNormal;
            if(self.currentSelectIndex == index){
                titleFont = self.config.fontSelected;
            }
            NSDictionary *attrs = @{NSFontAttributeName: titleFont};
            CGFloat itemWidth1 = [item.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil].size.width;
            
            CGFloat itemWidth2 = item.imageNormal.size.width*self.height/item.imageNormal.size.height;
            itemWidth2 = MIN(itemWidth2, item.imageNormal.size.width);
            if(self.currentSelectIndex == index && item.imageSelect){
                itemWidth2 = item.imageSelect.size.width*self.height/item.imageSelect.size.height;
                itemWidth2 = MIN(itemWidth2, item.imageSelect.size.width);
            }
            
            itemWidth = itemWidth1 + itemWidth2;
        }
            break;
        case YHPageTitleShowType_Attribute:{
            itemWidth = [item.attStringNormal yh_getSizeConstrainedToSize:CGSizeMake(FLT_MAX, self.height)].width;
            if(self.currentSelectIndex == index && item.attStringSelect){
                itemWidth = [item.attStringSelect yh_getSizeConstrainedToSize:CGSizeMake(FLT_MAX, self.height)].width;
            }
        }
            break;
            
        default:
            break;
    }
    
    CGFloat contentWidth = MAX(ceil(itemWidth), self.config.miniItemWidth);
    if(contentWidth == self.config.miniItemWidth){
        itemWidth = itemWidth + self.config.spaceItemInside * 2;
        contentWidth = MAX(ceil(itemWidth), self.config.miniItemWidth);
    }else{
        contentWidth = itemWidth + self.config.spaceItemInside * 2;
    }
    return contentWidth;
}


-(void)setCurrentSelectIndex:(NSInteger)currentSelectIndex{
    
    _currentSelectIndex = currentSelectIndex;

    [UIView animateWithDuration:0.3 animations:^{
        [self relayoutContentView];
    }];
    
    UIButton * selectBtn;
    for(UIButton * btn in self.btnList){
        if(btn.tag == currentSelectIndex){
            btn.selected = YES;
            selectBtn = btn;
            if(self.config.indicatorType == YHIndicatorType_Border){
                btn.layer.cornerRadius = self.config.cornerRadius;
                btn.layer.masksToBounds = YES;
                btn.layer.borderWidth = self.config.borderWidthSelect;
                btn.layer.borderColor = self.config.borderColorSelect.CGColor;
            }
        }else{
            //取消选中状态
            btn.selected = NO;
            if(self.config.indicatorType == YHIndicatorType_Border){
                btn.layer.cornerRadius = self.config.cornerRadius;
                btn.layer.masksToBounds = YES;
                btn.layer.borderWidth = self.config.borderWidthNormal;
                btn.layer.borderColor = self.config.borderColorNormal.CGColor;
            }
        }
    }
    
    [self updateIndicatorViewAnimation:YES];
    
    if(selectBtn){
        [self scrollToCenterWithSubView:selectBtn superViewwWidth:self.width];
    }
}

/// 该视图滚动到中心点
-(void)scrollToCenterWithSubView:(UIView *)view  superViewwWidth:(CGFloat)superViewwWidth
{
    if(self.contentView.contentSize.width == 0){
        return;
    }
    // 距离屏幕中心点距离
    CGFloat offsetX = view.center.x - superViewwWidth/2;
    if (offsetX < 0)
    {
        offsetX = 0;
    }
    // 超出屏幕部分的宽度
    CGFloat maxRight = self.contentView.contentSize.width - superViewwWidth;
    if (offsetX > maxRight)
    {
        // 当前屏幕左侧有超屏内容 只滚动右边剩余量
        offsetX = maxRight;
    }
    
    [self.contentView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateIndicatorViewAnimation:NO];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateIndicatorViewAnimation:NO];
}

- (void)updateIndicatorViewAnimation:(BOOL)animation{
    if(self.config.indicatorType == YHIndicatorType_None ||
       self.config.indicatorType == YHIndicatorType_Border){
        self.indicatorView.hidden = YES;
        return;
    }
    if(self.btnList.count == 0){
        self.indicatorView.hidden = YES;
        return;
    }
    
    self.indicatorView.hidden = NO;
    
    UIButton * selectBtn = [self.btnList objectAtIndex:self.currentSelectIndex];
    if(CGRectIsEmpty(selectBtn.frame)){
        return;
    }
        
    CGRect indicatorBounds = CGRectMake(0, 0, selectBtn.width, selectBtn.height);
    CGPoint indicatorCenter = CGPointMake(CGRectGetMidX(selectBtn.frame), 0);

    if(self.config.indicatorType == YHIndicatorType_Line){
        indicatorBounds.size.height = 2;
        indicatorCenter.y = CGRectGetHeight(self.frame) - self.config.indicatorLineBottomOffset;
    }
    
    if(!CGSizeEqualToSize(self.config.indicatorSize, CGSizeZero)){
        indicatorBounds.size = self.config.indicatorSize;
    }
    
    if(animation){
        [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            self.indicatorView.bounds = indicatorBounds;
            self.indicatorView.center = indicatorCenter;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        self.indicatorView.bounds = indicatorBounds;
        self.indicatorView.center = indicatorCenter;
    }
}

/// 滚动中切换效果
- (void)scrollingProgress:(CGFloat)progress direction:(BOOL)goLeft{
    
    if(self.config.progressAnimation == YHSegmentAnimation_None){
        return;
    }
    
    UIButton * currentBtn = [self getItemViewAtIndex:self.currentSelectIndex];
    UIButton * nextBtn = [self getItemViewAtIndex:goLeft?self.currentSelectIndex-1:self.currentSelectIndex+1];
    if(!nextBtn){
        NSLog(@"已经在边界了");
        return;
    }
    
    
    if(self.config.progressAnimation & YHSegmentAnimation_FontSize){
        //字体大小渐变
        UIFont * fontSelected = self.config.fontSelected.copy;
        UIFont * fontNormal = self.config.fontNormal.copy;
        
        CGFloat sizeNormal = fontNormal.pointSize;
        CGFloat sizeSelect = fontSelected.pointSize;
        CGFloat sizeAdapt = (sizeSelect - sizeNormal) * progress;
        fontSelected = [fontSelected fontWithSize:sizeSelect - sizeAdapt];
        fontNormal = [fontNormal fontWithSize:sizeNormal + sizeAdapt];
        
        currentBtn.titleLabel.font = fontSelected;
        nextBtn.titleLabel.font = fontNormal;
    }
    
    if(self.config.progressAnimation & YHSegmentAnimation_TextColor){
        //字体颜色渐变
        UIColor * colorSelected = [UIColor yh_transformFromColor:self.config.colorSelected toColor:self.config.colorNormal progress:progress];
        UIColor * colorNormal = [UIColor yh_transformFromColor:self.config.colorNormal toColor:self.config.colorSelected progress:progress];
        
        [currentBtn setTitleColor:colorSelected forState:UIControlStateNormal];
        [nextBtn setTitleColor:colorNormal forState:UIControlStateNormal];
        
        //边框渐变
        if(self.config.indicatorType == YHIndicatorType_Border){
            UIColor * colorSelected = [UIColor yh_transformFromColor:self.config.borderColorSelect toColor:self.config.borderColorNormal progress:progress];
            UIColor * colorNormal = [UIColor yh_transformFromColor:self.config.borderColorNormal toColor:self.config.borderColorSelect progress:progress];
            currentBtn.layer.borderColor = colorSelected.CGColor;
            nextBtn.layer.borderColor = colorNormal.CGColor;
            
            CGFloat borderWidthNormal = self.config.borderWidthNormal;
            CGFloat borderWidthSelect = self.config.borderWidthSelect;
            CGFloat sizeAdapt = (borderWidthSelect - borderWidthNormal) * progress;

            currentBtn.layer.borderWidth = borderWidthSelect - sizeAdapt;
            nextBtn.layer.borderWidth = borderWidthNormal + sizeAdapt;
        }
    }
    
    if(self.config.progressAnimation & YHSegmentAnimation_LineFadein){
        //指示器渐变
        if(self.config.indicatorType == YHIndicatorType_Line){
            
            if(progress == 1){
                
                [self updateIndicatorViewAnimation:YES];
                
            }else{
                CGSize sizeCurrent = currentBtn.frame.size;
                CGSize sizeNext = nextBtn.frame.size;
                if(!CGSizeEqualToSize(self.config.indicatorSize, CGSizeZero)){
                    sizeNext = self.config.indicatorSize;
                    sizeCurrent = self.config.indicatorSize;
                }
                CGRect currentRect = CGRectMake(currentBtn.frame.origin.x + (CGRectGetWidth(currentBtn.frame) - sizeCurrent.width)*0.5,
                                                self.indicatorView.frame.origin.y,
                                                sizeCurrent.width,
                                                self.indicatorView.frame.size.height);
                CGRect lastRect = CGRectMake(nextBtn.frame.origin.x + (CGRectGetWidth(nextBtn.frame) - sizeNext.width)*0.5,
                                             self.indicatorView.frame.origin.y,
                                             sizeNext.width,
                                             self.indicatorView.frame.size.height);
                
                if(goLeft){
                    CGFloat distance = currentRect.origin.x - lastRect.origin.x;
                    distance = distance * progress;
                    CGRect animationRect = currentRect;
                    animationRect.origin.x = animationRect.origin.x - distance;
                    animationRect.size.width = animationRect.size.width + distance;
                    self.indicatorView.frame = animationRect;
                }else{
                    CGFloat distance = CGRectGetMaxX(lastRect) - CGRectGetMaxX(currentRect);
                    distance = distance * progress;
                    CGRect animationRect = currentRect;
                    animationRect.size.width = animationRect.size.width + distance;
                    self.indicatorView.frame = animationRect;
                }
            }
        }
    }
    
    
    
}


@end



@implementation YHSegmentConfig

-(void)yh_commonInit{
    
    self.fontSelected = [UIFont yh_pflOfSize:16];
    self.fontNormal = [UIFont yh_pflOfSize:16];
    
    self.colorNormal = [UIColor yh_title_h2];
    self.colorSelected = [UIColor yh_blue];
 
    self.spaceItem = Adapted(10);
    self.spaceContentLeft = Adapted(10);
    self.spaceContentRight = Adapted(10);
    self.spaceContentTop = 0;
    self.spaceContentBottom = 0;
    
    self.miniItemWidth = Adapted(50);
    
    self.indicatorType = YHIndicatorType_Line;
    
    self.indicatorSize = CGSizeMake(Adapted(20), Adapted(4));
    
    self.indicatorLineBottomOffset = 5;
    
    self.spaceItemInside = 10;
    
    
    self.borderColorNormal = [UIColor systemGray2Color];
    self.borderColorSelect = [UIColor systemBlueColor];
    self.borderWidthNormal = 0.5;
    self.borderWidthSelect = 1.5;
    self.spaceItemInside = 20;
    self.spaceItem = 12;
    self.spaceContentLeft = 16;
    self.spaceContentRight = 16;
    self.spaceContentTop = 0;
    self.spaceContentBottom = 0;
}

@end

