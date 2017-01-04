//
//  FeedTableViewCell.m
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import "FeedTableViewCell.h"

static NSString *const kReplyCellIdentifier = @"reply";
static NSString *const kAppendStr = @"追问";
static NSString *const kSendStr = @"发送";
static NSString *const kCancelStr = @"取消";
static NSString *const kDeleteStr = @"删除";

@implementation ReplyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor colorWithRed:0.75 green:0.76 blue:0.76 alpha:1.00];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        
        _replyContentLabel = [[UILabel alloc] init];
        _replyContentLabel.numberOfLines = 0;
        _replyContentLabel.textColor = [UIColor blackColor];
        _replyContentLabel.font = [UIFont systemFontOfSize:15];
        
        
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_replyContentLabel];
        
    }
    return self;
}
- (void)fillCellWithReplyLayout:(ReplyLayout *)layout {
    
        _dateLabel.text = layout.reply.date;
        _dateLabel.frame = layout.dateRect;
        NSMutableAttributedString *replyContent = nil;
        
        if (layout.reply.isReply) {
            NSString *content = [NSString stringWithFormat:@"%@%@", kReply, layout.reply.content];
            replyContent = [[NSMutableAttributedString alloc] initWithString:content];
            [replyContent addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],
                                          NSFontAttributeName : [UIFont systemFontOfSize:18]} range:NSMakeRange(0, 2)];
        } else {
            NSString *content = [NSString stringWithFormat:@"%@%@", kAppend, layout.reply.content];
            replyContent = [[NSMutableAttributedString alloc] initWithString:content];
            [replyContent addAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor],
                                          NSFontAttributeName : [UIFont systemFontOfSize:18]} range:NSMakeRange(0, 2)];
        }
        _replyContentLabel.attributedText = replyContent;
        _replyContentLabel.frame = layout.contentRect;
   

}
@end

@implementation ToolbarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.borderStyle = UITextBorderStyleNone;
        _inputTextField.font = [UIFont systemFontOfSize:14];
        _inputTextField.textColor = [UIColor blackColor];
        _inputTextField.placeholder = @"请填写追问详情内容，150字以内";
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.tag = kDeleteTag;
        _deleteButton.backgroundColor = [UIColor whiteColor];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.cornerRadius = 3;
        [_deleteButton addTarget:self action:@selector(didPressDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _appendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _appendButton.tag = kAppendTag;
        _appendButton.backgroundColor = [UIColor whiteColor];
        _appendButton.layer.masksToBounds = YES;
        _appendButton.layer.cornerRadius = 3;
        _appendButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_appendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_appendButton setTitle:kAppendStr forState:UIControlStateNormal];
        //[_appendButton setTitle:kCancelStr forState:UIControlStateSelected];
        [_appendButton addTarget:self action:@selector(didPressAppendAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_inputTextField];
        [self addSubview:_deleteButton];
        [self addSubview:_appendButton];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _inputTextField.frame = CGRectMake(0, 0, self.frame.size.width, 25);
    _inputTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _inputTextField.layer.borderWidth = 0.8;
    _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    _appendButton.frame = CGRectMake(self.frame.size.width - (60 + 10), self.frame.size.height - (10 + 30), 60, 30);
    _appendButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _appendButton.layer.borderWidth = 0.8;
    
    _deleteButton.frame = CGRectMake(CGRectGetMinX(_appendButton.frame) - (60 + 10), CGRectGetMinY(_appendButton.frame), 60, 30);
    _deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _deleteButton.layer.borderWidth = 0.8;
}
- (void)didPressDeleteAction:(UIButton *)button {
    if (_toolbarDeleteEvent) {
        _toolbarDeleteEvent(button);
    }
}
- (void)didPressAppendAction:(UIButton *)button {
    if (_toolbarAppendEvent) {
        _toolbarAppendEvent(button);
    }
}
@end

@implementation FeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor colorWithRed:0.75 green:0.76 blue:0.76 alpha:1.00];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textColor = [UIColor blackColor];
        _stateLabel.font = [UIFont systemFontOfSize:12];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        
        _questionLabel = [[UILabel alloc] init];
        _questionLabel.textColor = [UIColor blackColor];
        _questionLabel.font = [UIFont systemFontOfSize:15];
        _questionLabel.numberOfLines = 0;
        
        _replyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _replyTableView.delegate = self;
        _replyTableView.dataSource = self;
        _replyTableView.tableFooterView = [UIView new];
        _replyTableView.showsVerticalScrollIndicator = NO;
        _replyTableView.showsHorizontalScrollIndicator = NO;
        _replyTableView.scrollEnabled = NO;
        [_replyTableView registerClass:[ReplyTableViewCell class] forCellReuseIdentifier:kReplyCellIdentifier];
        
        _toolbar = [[ToolbarView alloc] init];
        [_toolbar.inputTextField addTarget:self action:@selector(didInput:) forControlEvents:UIControlEventEditingChanged];
        [_toolbar.inputTextField addTarget:self action:@selector(endInput:) forControlEvents:UIControlEventEditingDidEnd];
        
        _toolbar.toolbarDeleteEvent = ^(UIButton *button) {
            if ([button.currentTitle isEqualToString:kCancelStr]) {
                if ([weakSelf.delegate respondsToSelector:@selector(cell:didClickAppendButton:indexPath:)]) {
                    [weakSelf.delegate cell:weakSelf didClickAppendButton:button indexPath:weakSelf.indexPath];
                }
            } else {
                if ([weakSelf.delegate respondsToSelector:@selector(cell:didClickDeleteButton:indexPath:)]) {
                    [weakSelf.delegate cell:weakSelf didClickDeleteButton:button indexPath:weakSelf.indexPath];
                }
            }
            
        };
        _toolbar.toolbarAppendEvent = ^(UIButton *button) {
            if ([button.currentTitle isEqualToString:kAppendStr] || [button.currentTitle isEqualToString:kCancelStr]) {
                if ([weakSelf.delegate respondsToSelector:@selector(cell:didClickAppendButton:indexPath:)]) {
                    [weakSelf.delegate cell:weakSelf didClickAppendButton:button indexPath:weakSelf.indexPath];
                }
            } else if ([button.currentTitle isEqualToString:kSendStr] && weakSelf.toolbar.inputTextField.text.length > 0) {
                if ([weakSelf.delegate respondsToSelector:@selector(cell:didInputDone:)] ) {
                    [weakSelf.delegate cell:weakSelf didInputDone:weakSelf.toolbar.inputTextField];
                }
            } else {
                if ([weakSelf.delegate respondsToSelector:@selector(cell:didClickAppendButton:indexPath:)]) {
                    [weakSelf.delegate cell:weakSelf didClickAppendButton:button indexPath:weakSelf.indexPath];
                }
            }
            
        };
        
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_stateLabel];
        [self.contentView addSubview:_questionLabel];
        [self.contentView addSubview:_replyTableView];
        [self.contentView addSubview:_toolbar];
        
    }
    return self;
}
- (void)didInput:(UITextField *)textField {
    if (textField.text.length > 0) {
        [_toolbar.appendButton setTitle:kSendStr forState:UIControlStateNormal];
    } else {
        [_toolbar.appendButton setTitle:kCancelStr forState:UIControlStateNormal];
    }
}
- (void)endInput:(UITextField *)textField {
    [_toolbar.appendButton setTitle:kAppendStr forState:UIControlStateNormal];
    textField.text = @"";
}

- (void)fillCellWithLayout:(FeedLayout *)layout indexPath:(NSIndexPath *)indexPath {
    
    _layout = layout;
    _indexPath = indexPath;
    
    _dateLabel.text = layout.feed.date;
    _dateLabel.frame = layout.dateRect;
    
    _stateLabel.text = layout.feed.state;
    _stateLabel.frame = layout.stateRect;
    
    _questionLabel.text = layout.feed.question;
    _questionLabel.frame = layout.questionRect;
    
    _replyTableView.frame = layout.tableViewRect;
    
    _toolbar.frame = layout.toolbarRect;
    if (layout.feed.isAppend) {
        
        [_toolbar.appendButton setTitle:kSendStr forState:UIControlStateNormal];
        [_toolbar.appendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _toolbar.appendButton.backgroundColor = [UIColor redColor];
        _toolbar.appendButton.layer.borderColor = [UIColor clearColor].CGColor;
        _toolbar.appendButton.layer.borderWidth = 0.0;
        _toolbar.appendButton.layer.cornerRadius = 3;
        _toolbar.inputTextField.hidden = NO;
        
        [_toolbar.deleteButton setTitle:kCancelStr forState:UIControlStateNormal];
    } else {
        [_toolbar.appendButton setTitle:kAppendStr forState:UIControlStateNormal];
        [_toolbar.appendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _toolbar.appendButton.backgroundColor = [UIColor whiteColor];
        _toolbar.appendButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _toolbar.appendButton.layer.borderWidth = 0.8;
        _toolbar.appendButton.layer.cornerRadius = 3;
        _toolbar.inputTextField.hidden = YES;
        
        [_toolbar.deleteButton setTitle:kDeleteStr forState:UIControlStateNormal];
    }
    
    [_replyTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _layout.feed.replyLayouts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReplyCellIdentifier];
    [cell fillCellWithReplyLayout:_layout.feed.replyLayouts[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _layout.feed.replyLayouts[indexPath.row].height;
}
@end
