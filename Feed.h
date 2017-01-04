//
//  Feed.h
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReplyLayout.h"

@interface Feed : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *question;
@property (nonatomic, strong) NSMutableArray<ReplyLayout *> *replyLayouts;
@property (nonatomic, assign) BOOL isAppend;

@end
