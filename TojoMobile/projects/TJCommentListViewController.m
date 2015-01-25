//
//  TJCommentViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJCommentListViewController.h"
#import "MJRefresh.h"
#import "TJCommentListCell.h"
#import "TJProjectSender.h"
#import "TJCommentListViewModel.h"
#import "TJCommentViewController.h"

@interface TJCommentListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (nonatomic, strong) TJCommentListViewModel *viewModel;

@end

@implementation TJCommentListViewController{
    dispatch_once_t onceToken;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"评论";
    [self.commentTableView setDelegate:self];
    [self.commentTableView setDataSource:self];
    
    _viewModel = [[TJCommentListViewModel alloc] init];
    [self loadCommentList];
    
    //定义上拉、下拉加载数据
    [self updateDataSource];
}

//定义上拉下拉刷新数据的方法。
- (void)updateDataSource
{
    __block TJCommentListViewController *commentVc = self;
    
    //下拉刷新
    [self.commentTableView addHeaderWithCallback:^{
        //下拉工作
    }];
    
    //上拉加载更多
//    [self.commentTableView addFooterWithCallback:^{
//        //上拉
//    }];
}

#pragma mark --------- 发服务 -----------
-(void) loadCommentList
{
    [[TJProjectSender getInstance] sendGetCommentListWithViewModel:_viewModel completeBlock:^(BOOL success, NSString *    message) {
        if (success) {
            NSLog(@"success");
            //页面进行赋值
            [self.commentTableView reloadData];
        }
        else {
            NSLog(@"falied");
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSUInteger count = [_viewModel.commentList count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_once(&onceToken, ^{
        [tableView registerNib:[UINib nibWithNibName:@"TJCommentListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJCommentListCell"];
    });
    static NSString *cellId = @"TJCommentListCell";
    TJCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    TJCommentModel *commentModel = (TJCommentModel *)[_viewModel.commentList objectAtIndex:indexPath.row];
    [cell setCellWithCommentItem:commentModel];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击评论
    TJCommentViewController *commentViewController = [[TJCommentViewController alloc] init];
    
    [self.navigationController pushViewController:commentViewController animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
