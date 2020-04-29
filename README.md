

> 分页控制器是基于系统的UIPageViewController实现

# 效果展示

1. 支持标题栏设置在导航条上方

    ![image.png](https://upload-images.jianshu.io/upload_images/2019043-92a7a5fa986cca30.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

2. 未读消息数设置

    ![image.png](https://upload-images.jianshu.io/upload_images/2019043-1784eea5e7ef17a1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

3. 多种样式

    ![image.png](https://upload-images.jianshu.io/upload_images/2019043-73a3430dd36af8df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

    ![image.png](https://upload-images.jianshu.io/upload_images/2019043-5e0b3bc0afbf1b0d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)


4. page嵌套page

    ![image.png](https://upload-images.jianshu.io/upload_images/2019043-3e96b2f9e8387b17.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

5. vc的Scrollview嵌套PageVC

    ![滚动示例](https://upload-images.jianshu.io/upload_images/2019043-f8e489c94b0c5bbe.gif?imageMogr2/auto-orient/strip)

6. 标签切换动画

    ![标签动画效果图](https://upload-images.jianshu.io/upload_images/2019043-a83861e5377850b5.gif?imageMogr2/auto-orient/strip)

---

# 使用示例：

以下是使用继承YHPageViewController的方式
```
    //标签栏是否显示在导航条上方
    self.segmentMenuShowOnNavigationBar = YES;
    
    //添加他的自控制器 和他的标题配置
    [self yh_addChildController:[YHColorViewController new] title:@"标题1"];
    [self yh_addChildController:[YHColorViewController new] title:@"标题2"];
    [self yh_addChildController:[YHColorViewController new] title:@"标题3"];
    [self yh_addChildController:[YHTableViewController new] title:@"标题1111"];
    [self yh_addChildController:[YHTableViewController new] title:@"标题222LLLooonnnnnnngg"];
    [self yh_addChildController:[YHTableViewController new] titleConfig:^(YHPageTitleItem * _Nonnull item) {
        item.title = @"标题333";
    }];
    
    //标签栏上标题字体 间距 布局 指示器 等设置
    self.segmentControl.config.layoutType = YHSegmentLayoutType_Left;
    self.segmentControl.config.progressAnimation = YHSegmentAnimation_LineFadein;
    self.segmentControl.config.fontSelected = [UIFont yh_pfmOfSize:20];
    self.segmentControl.config.fontSelected = [UIFont yh_pfOfSize:16];

    //这个需要调用一次
    [self yh_reloadController];
    
    //初始选中位置
    self.selectIndex = 4;
```


如果要实现PageViewController他的HeaderView悬浮的方式，可以去继承`YHPageHeaderViewController`控制器，也可以单独把分页控制器添加到自定义的`YHPageScrollView`scrollview的子类中，自定义滚动悬浮效果。

示例：
```
    self.scrollView = [YHPageScrollView new];
    //设置他的最大滚动偏移高度
    self.scrollView.maxOffsetY = [self yh_pageHeaderHeight];
    [self.scrollView setDidScrollBlock:^(CGFloat offy) {
        ...
    }];
    [self.view addSubview:self.scrollView];
    ...
    
    self.pageHeaderView = [self yh_pageHeaderView];
    [self.scrollView addSubview:self.pageHeaderView];
    ...
    
    self.pageViewController = [YHPageViewController new];
    ...
```


欢迎 issues me

