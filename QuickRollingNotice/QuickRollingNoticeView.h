//
//  QuickRollingNoticeView.h
//  QuickRollingNotice
//
//  Created by pcjbird on 2018/1/17.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickRollingNoticeCell.h"


@class QuickRollingNoticeView;
@protocol QuickRollingNoticeViewDataSource <NSObject>
@required
- (NSInteger)numberOfRowsForRollingNoticeView:(QuickRollingNoticeView *)rollingView;
- (QuickRollingNoticeCell *)rollingNoticeView:(QuickRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index;
@end

@protocol QuickRollingNoticeViewDelegate <NSObject>
@optional
- (void)didClickRollingNoticeView:(QuickRollingNoticeView *)rollingView forIndex:(NSUInteger)index;

@end

/**
 * @brief QuickRollingNoticeView 滚动视图（容器）
 */
@interface QuickRollingNoticeView : UIView

/**
 * @brief 数据源
 */
@property (nonatomic, weak, nullable) id<QuickRollingNoticeViewDataSource> dataSource;

/**
 * @brief 代理
 */
@property (nonatomic, weak, nullable) id<QuickRollingNoticeViewDelegate> delegate;

/**
 * @brief 停留时间 默认2秒
 */
@property (nonatomic, assign) NSTimeInterval stayInterval;

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier;
- (__kindof QuickRollingNoticeCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

/**
 * @brief 开始滚动
 */
- (void)startRoll;

/**
 * @brief 停止滚动
 */
- (void)stopRoll;

@end
