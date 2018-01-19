//
//  QuickRollingNoticeView.m
//  QuickRollingNotice
//
//  Created by pcjbird on 2018/1/17.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import "QuickRollingNoticeView.h"
#import <CoreGraphics/CoreGraphics.h>


@interface QuickRollingNoticeView ()
{
    BOOL _isAnimating;
}
@property (nonatomic, strong) NSMutableDictionary *cellClsDict;
@property (nonatomic, strong) NSMutableArray *reuseCells;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) QuickRollingNoticeCell *currentCell;
@property (nonatomic, strong) QuickRollingNoticeCell *willShowCell;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation QuickRollingNoticeView

- (instancetype)init
{
    if (self = [super init])
    {
         [self initVariables];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initVariables];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self initVariables];
    }
    return self;
}

-(void) initVariables
{
    _isAnimating = NO;
    self.clipsToBounds = YES;
    _stayInterval = 2;
    [self addGestureRecognizer:self.tapGesture];
}


- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier
{
    [self.cellClsDict setObject:NSStringFromClass(cellClass) forKey:identifier];
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier
{
    [self.cellClsDict setObject:nib forKey:identifier];
}

- (__kindof QuickRollingNoticeCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    for (QuickRollingNoticeCell *cell in self.reuseCells)
    {
        if ([cell.reuseIdentifier isEqualToString:identifier])
        {
            return cell;
        }
    }
    
    id cellClass = self.cellClsDict[identifier];
    if ([cellClass isKindOfClass:[UINib class]])
    {
        UINib *nib = (UINib *)cellClass;
        
        NSArray *arr = [nib instantiateWithOwner:nil options:nil];
        QuickRollingNoticeCell *cell = [arr firstObject];
        [cell setValue:identifier forKeyPath:@"reuseIdentifier"];
        return cell;
    }
    else
    {
        Class cellCls = NSClassFromString(self.cellClsDict[identifier]);
        QuickRollingNoticeCell *cell = [[cellCls alloc] initWithReuseIdentifier:identifier];
        return cell;
    }
    
}


#pragma mark- rolling
- (void)layoutCurrentCellAndWillShowCell
{
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_currentIndex > count - 1)
    {
        _currentIndex = 0;
    }
    
    int willShowIndex = _currentIndex + 1;
    if (willShowIndex > count - 1)
    {
        willShowIndex = 0;
    }
    
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    
    if (!_currentCell)
    {
        _currentCell = [self.dataSource rollingNoticeView:self cellAtIndex:_currentIndex];
        _currentCell.frame  = CGRectMake(0, 0, w, h);
        [self addSubview:_currentCell];
        return;
    }
    
    _willShowCell = [self.dataSource rollingNoticeView:self cellAtIndex:willShowIndex];
    _willShowCell.frame = CGRectMake(0, h, w, h);
    [self addSubview:_willShowCell];
    
    [self.reuseCells removeObject:_currentCell];
    [self.reuseCells removeObject:_willShowCell];
}

- (void)startRoll
{
    [self stopRoll];
    
    [self layoutCurrentCellAndWillShowCell];
    NSInteger count = [self.dataSource numberOfRowsForRollingNoticeView:self];
    if (count && count < 2)
    {
        return;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_stayInterval target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopRoll
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    _currentIndex = 0;
    if(_currentCell)[_currentCell removeFromSuperview];
    if(_willShowCell)[_willShowCell removeFromSuperview];
    _currentCell = nil;
    _willShowCell = nil;
    _isAnimating = NO;
    [self.reuseCells removeAllObjects];
}

- (void)timerHandle
{
    if(_isAnimating) return;
    [self layoutCurrentCellAndWillShowCell];
    _currentIndex ++;
    
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    _isAnimating = YES;
    [UIView animateWithDuration:0.5 animations:^{
        _currentCell.frame = CGRectMake(0, -h, w, h);
        _willShowCell.frame = CGRectMake(0, 0, w, h);
    }
    completion:^(BOOL finished) {
        if (_currentCell && _willShowCell)
        {
            [self.reuseCells addObject:_currentCell];
            [_currentCell removeFromSuperview];
            _currentCell = _willShowCell;
        }
        _isAnimating = NO;
    }];
}


- (void)handleCellTapAction
{
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    if ([self.delegate respondsToSelector:@selector(didClickRollingNoticeView:forIndex:)]) {
        [self.delegate didClickRollingNoticeView:self forIndex:_currentIndex];
    }
}

#pragma mark- lazy
- (NSMutableDictionary *)cellClsDict
{
    if (nil == _cellClsDict)
    {
        _cellClsDict = [[NSMutableDictionary alloc]init];
    }
    return _cellClsDict;
}

- (NSMutableArray *)reuseCells
{
    if (nil == _reuseCells)
    {
        _reuseCells = [[NSMutableArray alloc]init];
    }
    return _reuseCells;
}
- (UITapGestureRecognizer *)tapGesture
{
    if (nil == _tapGesture)
    {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCellTapAction)];
    }
    return _tapGesture;
}
@end
