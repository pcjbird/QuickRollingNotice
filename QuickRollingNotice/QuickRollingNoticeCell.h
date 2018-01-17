//
//  QuickRollingNoticeCell.h
//  QuickRollingNotice
//
//  Created by pcjbird on 2018/1/17.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @brief QuickRollingNoticeCell 滚动的Cell
 */
@interface QuickRollingNoticeCell : UIView

@property (nonatomic, readonly, strong) UIView *contentView;
@property (nonatomic, readonly, strong) UILabel *textLabel;
@property (nonatomic, readonly,   copy) NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end
