//
//  FeedTableViewCell.h
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedLayout.h"

static NSInteger const kDeleteTag = 6666;
static NSInteger const kAppendTag = 9999;

@class FeedTableViewCell;

@protocol FeedTableViewCellDelegate <NSObject>

- (void)cell:(FeedTableViewCell *)cell didClickDeleteButton:(UIButton *)deleteButton indexPath:(NSIndexPath *)indexPath;

- (void)cell:(FeedTableViewCell *)cell didClickAppendButton:(UIButton *)appendButton indexPath:(NSIndexPath *)indexPath;

- (void)cell:(FeedTableViewCell *)cell didInputDone:(UITextField *)inputTextField;

@end

@interface ReplyTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *replyContentLabel;

@end

@interface ToolbarView : UIView

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *appendButton;
@property (nonatomic, copy) void(^toolbarDeleteEvent)(UIButton *button);
@property (nonatomic, copy) void(^toolbarAppendEvent)(UIButton *button);

@end

@interface FeedTableViewCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UITableView *replyTableView;
@property (nonatomic, strong) ToolbarView *toolbar;
@property (nonatomic, strong) FeedLayout *layout;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id <FeedTableViewCellDelegate> delegate;

- (void)fillCellWithLayout:(FeedLayout *)layout indexPath:(NSIndexPath *)indexPath;

@end
