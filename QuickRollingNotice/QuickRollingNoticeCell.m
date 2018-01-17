//
//  QuickRollingNoticeCell.m
//  QuickRollingNotice
//
//  Created by pcjbird on 2018/1/17.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import "QuickRollingNoticeCell.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation QuickRollingNoticeCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:CGRectZero])
    {
        _reuseIdentifier = reuseIdentifier;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _reuseIdentifier = @"QuickRollingNoticeCellReUseIdentifier";
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithReuseIdentifier:@"QuickRollingNoticeCellReUseIdentifier"];
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    _textLabel = [[UILabel alloc]init];
    [_contentView addSubview:_textLabel];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = self.bounds;
    _textLabel.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
}

- (void)dealloc
{
    
}

@end
