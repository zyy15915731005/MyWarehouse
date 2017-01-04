//
//  FeedLayout.h
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+Size.h"
#import "Feed.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat const kFeedCellMargin = 15;
static CGFloat const kFeedCellDateWidth = 100;
static CGFloat const kFeedCellDateHeight = 20;
static CGFloat const kFeedCellToolbarHeight = 90;

@interface FeedLayout : NSObject

@property (nonatomic, assign) CGRect dateRect;
@property (nonatomic, assign) CGRect stateRect;
@property (nonatomic, assign) CGRect questionRect;
@property (nonatomic, assign) CGRect tableViewRect;
@property (nonatomic, assign) CGRect toolbarRect;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) Feed *feed;

- (instancetype)initWithFeed:(Feed *)feed;

@end
