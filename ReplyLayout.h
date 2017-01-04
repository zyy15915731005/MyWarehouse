//
//  ReplyLayout.h
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+Size.h"
#import "Reply.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat const kReplyCellMargin = 15;
static CGFloat const kReplyCellDateWidth = 100;
static CGFloat const kReplyCellDateHeight = 20;
static NSString *const kReply = @"回复:";
static NSString *const kAppend = @"追问:";

@interface ReplyLayout : NSObject

@property (nonatomic, assign) CGRect dateRect;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) Reply *reply;

- (instancetype)initWithReply:(Reply *)reply;

@end
