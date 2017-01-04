//
//  FeedLayout.m
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import "FeedLayout.h"

@implementation FeedLayout

- (instancetype)initWithFeed:(Feed *)feed {
    self = [super init];
    if (self) {
        _feed = feed;
        _height = 0;
        [self _layout];
    }
    return self;
}

- (void)_layout {
    [self _dateLayout];
    [self _stateLayout];
    [self _questionLayout];
    [self _tableViewLayout];
    [self _toolbarLayout];
}
- (void)_dateLayout {
    _dateRect = CGRectMake(kFeedCellMargin, 0, kFeedCellDateWidth, kFeedCellDateHeight);
    _height = CGRectGetHeight(_dateRect);
}
- (void)_stateLayout {
    _stateRect = CGRectMake(kScreenWidth - CGRectGetWidth(_dateRect),
                            CGRectGetMinY(_dateRect),
                            CGRectGetWidth(_dateRect),
                            CGRectGetHeight(_dateRect));
    _height = CGRectGetHeight(_stateRect);
}
- (void)_questionLayout {
    CGFloat maxWidth = kScreenWidth - (kReplyCellMargin * 2);
    CGSize contentSize = [_feed.question sizeWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:maxWidth];
    _questionRect = CGRectMake(kReplyCellMargin, CGRectGetMaxY(_dateRect), contentSize.width, contentSize.height);
    _height += CGRectGetHeight(_questionRect);
}
- (void)_tableViewLayout {
    CGFloat height = 0;
    NSInteger count = _feed.replyLayouts.count;
    for (NSInteger i = 0; i < count; i++) {
        height += _feed.replyLayouts[i].height;
    }
    _tableViewRect = CGRectMake(kFeedCellMargin,
                                CGRectGetMaxY(_questionRect),
                                kScreenWidth - (kFeedCellMargin * 2),
                                height);
    _height += height;
}
- (void)_toolbarLayout {
    if (_feed.isAppend) {
        _toolbarRect = CGRectMake(CGRectGetMinX(_tableViewRect) + kFeedCellMargin,
                                  CGRectGetMaxY(_tableViewRect) + kFeedCellMargin,
                                  CGRectGetWidth(_tableViewRect) - (kFeedCellMargin * 2),
                                  kFeedCellToolbarHeight);
    } else {
        _toolbarRect = CGRectMake(CGRectGetMinX(_tableViewRect) + kFeedCellMargin,
                                  CGRectGetMaxY(_tableViewRect) + kFeedCellMargin,
                                  CGRectGetWidth(_tableViewRect) - (kFeedCellMargin * 2),
                                  kFeedCellToolbarHeight / 2);
    }
    _height += CGRectGetHeight(_toolbarRect) + kFeedCellMargin;
}
@end
