//
//  TJTeamViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTeamListViewController.h"
#import "TJTeamListCell.h"
#import "TJTeamListViewModel.h"
#import "TJProjectSender.h"
#import "TJCreateTeamViewController.h"
#import "TJTeamDetailViewController.h"

@interface TJTeamListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *teamTableView;
@property (nonatomic, strong) TJTeamListViewModel *viewModel;

@end

@implementation TJTeamListViewController{
    dispatch_once_t onceToken;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"团队";
    [self.teamTableView setDelegate:self];
    [self.teamTableView setDataSource:self];
    
    _viewModel = [[TJTeamListViewModel alloc] init];
    [self loadTeamList];
    
    
}

#pragma mark --------- 发服务 -----------
-(void) loadTeamList
{
    [[TJProjectSender getInstance] sendGetTeamListWithViewModel:_viewModel completeBlock:^(BOOL success, NSString *    message) {
        if (success) {
            NSLog(@"success");
            //页面进行赋值
            [self.teamTableView reloadData];
        }
        else {
            NSLog(@"falied");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSUInteger count = [_viewModel.teamList count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_once(&onceToken, ^{
        [tableView registerNib:[UINib nibWithNibName:@"TJTeamListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJTeamListCell"];
    });
    static NSString *cellId = @"TJTeamListCell";
    TJTeamListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    TJTeamModel *teamModel = (TJTeamModel *)[_viewModel.teamList objectAtIndex:indexPath.row];
    [cell setCellWithTeamItem:teamModel];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击团队
    TJTeamDetailViewController *teamDeatailVC = [[TJTeamDetailViewController alloc] init];
    TJTeamModel *teamModel = (TJTeamModel *)[_viewModel.teamList objectAtIndex:indexPath.row];
    [teamDeatailVC setTeamId:teamModel.teamId];
    [self.navigationController pushViewController:teamDeatailVC animated:YES];
}


- (IBAction)createTeam:(UIButton *)sender {
    TJCreateTeamViewController *createTeamViewController = [[TJCreateTeamViewController alloc] init];
    
    [self.navigationController pushViewController:createTeamViewController animated:YES];
}

- (IBAction)attendByOneself:(UIButton *)sender {
}
@end
