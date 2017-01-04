//
//  Reply.h
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reply : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL isReply;

@end
