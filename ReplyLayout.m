//
//  ReplyLayout.m
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import "ReplyLayout.h"

@implementation ReplyLayout

- (instancetype)initWithReply:(Reply *)reply {
    self = [super init];
    if (self) {
        _reply = reply;
        _height = 0;
        [self _layout];
    }
    return self;
}

- (void)_layout {
    [self _dateLayout];
    [self _contentLayout];
}

- (void)_dateLayout {
    _dateRect = CGRectMake(kReplyCellMargin, 0, kReplyCellDateWidth, kReplyCellDateHeight);
    _height = CGRectGetHeight(_dateRect);
}

- (void)_contentLayout {
    NSString *content = _reply.isReply ?
    [NSString stringWithFormat:@"%@%@", kReply, _reply.content] :
    [NSString stringWithFormat:@"%@%@", kAppend, _reply.content];
    
    if (content.length == 0 ||
        !content ||
        [content isEqual:[NSNull null]] ||
        [content isEqualToString:@""]) {
        content = @"";
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:content];
    
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, content.length)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, content.length)];
    
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 2)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    
    CGFloat maxWidth = kScreenWidth - (kReplyCellMargin * 4);
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                     options:(NSStringDrawingUsesLineFragmentOrigin |
                                              NSStringDrawingTruncatesLastVisibleLine)
                                     context:nil].size;
    //CGSize contentSize = [content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:maxWidth];
    _contentRect = CGRectMake(kReplyCellMargin, CGRectGetMaxY(_dateRect), ceil(size.width), ceil(size.height));
    _height += CGRectGetHeight(_contentRect) + kReplyCellMargin;
}
@end
