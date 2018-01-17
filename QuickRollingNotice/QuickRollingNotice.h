//
//  QuickRollingNotice.h
//  QuickRollingNotice
//
//  Created by pcjbird on 2018/1/17.
//  Copyright © 2018年 Zero Status. All rights reserved.
//
//  框架名称:QuickRollingNotice
//  框架功能: Roll Notice or Advertising, Customize cell as UITableViewCell supported. 滚动公告、广告，支持灵活自定义cell。
//  修改记录:
//     pcjbird    2018-01-17  Version:1.0.0 Build:201801170001
//                            1.首次发布SDK版本

#import <UIKit/UIKit.h>

//! Project version number for QuickRollingNotice.
FOUNDATION_EXPORT double QuickRollingNoticeVersionNumber;

//! Project version string for QuickRollingNotice.
FOUNDATION_EXPORT const unsigned char QuickRollingNoticeVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <QuickRollingNotice/PublicHeader.h>

#if __has_include("QuickRollingNoticeCell.h")
#import "QuickRollingNoticeCell.h"
#endif

#if __has_include("QuickRollingNoticeView.h")
#import "QuickRollingNoticeView.h"
#endif
