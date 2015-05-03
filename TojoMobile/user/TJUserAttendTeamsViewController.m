//
//  TJUserAttendTeamsViewController.m
//  TojoMobile
//
//  Created by sdq on 15/3/5.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserAttendTeamsViewController.h"
#import "TJUserAttendTeamListViewModel.h"
#import "TJProjectSender.h"
#import "TJTeamListCell.h"

@interface TJUserAttendTeamsViewController ()
@property (nonatomic,strong) TJUserAttendTeamListViewModel *viewModel;
@end

@implementation TJUserAttendTeamsViewController {
    dispatch_once_t onceToken;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"我参与的团队";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setExtraCellLineHidden:self.tableView];
    
    if (!_viewModel) {
        _viewModel = [[TJUserAttendTeamListViewModel alloc] init];
    }
    
    [self loadTeamList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------- 发服务 -----------
-(void) loadTeamList
{
    [[TJProjectSender getInstance] sendGetUserTeamListWithViewModel:_viewModel withUserId:1 completeBlock:^(BOOL success, NSString *message) {
        if (success) {
            NSLog(@"success");
            [self.tableView reloadData];
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
    NSUInteger count = [_viewModel.userTeamList count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_once(&onceToken, ^{
        [tableView registerNib:[UINib nibWithNibName:@"TJTeamListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJTeamListCell"];
    });
    static NSString *cellId = @"TJTeamListCell";
    TJTeamListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    TJTeamModel *infoModel = (TJTeamModel *)[_viewModel.userTeamList objectAtIndex:indexPath.row];
    [cell setCellWithTeamItem:infoModel];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

//消除多余分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
