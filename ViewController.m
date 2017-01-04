//
//  ViewController.m
//  FeedDemo
//
//  Created by DING on 16/11/24.
//  Copyright © 2016年 DING. All rights reserved.
//

#import "ViewController.h"
#import "FeedTableViewCell.h"

static NSString *const kFeedCellIdentifier = @"feed";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, FeedTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (nonatomic, strong) NSMutableArray<FeedLayout *> *feedLayouts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.feedTableView registerClass:[FeedTableViewCell class] forCellReuseIdentifier:kFeedCellIdentifier];    
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    self.feedTableView.tableFooterView = [UIView new];
    
    //  据悉，特朗普的团队曾向白宫询问候任总统的孩子是否能拥有查阅最高安全机密的许可。特朗普的子女如果想要拥有审阅机密的权力，需要被白宫任命为特朗普的国家安全顾问，要填写安全调查问卷，并且通过必要的背景调查。
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"feed" ofType:@"geojson"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
        
        NSError *error = nil;
        NSArray *jsonArray = ((NSDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments |NSJSONReadingMutableContainers error:&error])[@"feeds"];
        
        NSMutableArray<FeedLayout *> *feedLayouts = [NSMutableArray array];
        for (NSInteger i = 0; i < jsonArray.count; i++) {
            NSDictionary *feedDict = jsonArray[i];
            
            NSMutableArray<ReplyLayout *> *replyLayouts = [NSMutableArray array];
            NSArray *replyArray = feedDict[@"reply"];
            for (NSInteger i = 0; i < replyArray.count; i++) {
                NSDictionary *replyDict = replyArray[i];
                Reply *reply = [[Reply alloc] init];
                reply.date = replyDict[@"date"];
                reply.content = replyDict[@"text"];
                reply.isReply = i % 2 == 0 ? YES : NO;
                [replyLayouts addObject:[[ReplyLayout alloc] initWithReply:reply]];
            }
            
            Feed *feed = [[Feed alloc] init];
            feed.date = feedDict[@"date"];
            feed.state = feedDict[@"state"];
            feed.question = feedDict[@"question"];
            feed.replyLayouts = replyLayouts;
            feed.isAppend = NO;
            
            [feedLayouts addObject:[[FeedLayout alloc] initWithFeed:feed]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.feedLayouts = feedLayouts;
            [self.feedTableView reloadData];
        });
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cell:(FeedTableViewCell *)cell didClickDeleteButton:(UIButton *)deleteButton indexPath:(NSIndexPath *)indexPath {
    NSIndexPath *deleteIndexPath = [self.feedTableView indexPathForCell:cell];

    [self.feedLayouts removeObjectAtIndex:deleteIndexPath.section];
    
    [self.feedTableView deleteSections:[NSIndexSet indexSetWithIndex:deleteIndexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
}
- (void)cell:(FeedTableViewCell *)cell didClickAppendButton:(UIButton *)appendButton indexPath:(NSIndexPath *)indexPath {
    
    /******
     
     点击cell上的 追问 按钮
     1：拿到点击对应的 indexPath
     2：从数据源数组里取对应的model
     3：更新这个model的 isAppend bool 值
     4：重新创建一个layout对象
     5：替换原来的layout对象（此时新的layout对象的height是重新计算的）
     6：没必要reload 整个tableview 所以reload这一行就行 （就是这里 妈蛋 坑死了  reload 之后cell上的所有状态恢复到了初始值）
     ******/
    NSIndexPath *appendIndexPath = [self.feedTableView indexPathForCell:cell];
    
    Feed *feed = self.feedLayouts[appendIndexPath.section].feed;
    feed.isAppend = !feed.isAppend;
    FeedLayout *feedLayout = [[FeedLayout alloc] initWithFeed:feed];
    [self.feedLayouts replaceObjectAtIndex:appendIndexPath.section withObject:feedLayout];
    
    [self.feedTableView reloadRowsAtIndexPaths:@[appendIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}
- (void)cell:(FeedTableViewCell *)cell didInputDone:(UITextField *)inputTextField {
    NSIndexPath *appendIndexPath = [self.feedTableView indexPathForCell:cell];
    
    Reply *reply = [[Reply alloc] init];
    reply.date = @"2016-11-25";
    reply.content = inputTextField.text;
    reply.isReply = NO;
    ReplyLayout *replyLayout = [[ReplyLayout alloc] initWithReply:reply];
    
    Feed *feed = self.feedLayouts[appendIndexPath.section].feed;
    feed.isAppend = NO;
    [feed.replyLayouts addObject:replyLayout];
    NSLog(@"---done:%ld", feed.replyLayouts.count);
    
    FeedLayout *feedLayout = [[FeedLayout alloc] initWithFeed:feed];
    [self.feedLayouts replaceObjectAtIndex:appendIndexPath.section withObject:feedLayout];
    
    [self.feedTableView reloadRowsAtIndexPaths:@[appendIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.feedLayouts.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedCellIdentifier];
    cell.delegate = self;
    [cell fillCellWithLayout:self.feedLayouts[indexPath.section] indexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.feedLayouts[indexPath.section].height;
}

@end
