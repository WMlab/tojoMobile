//
//  TJTeamViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTeamListViewController.h"
#import "TJTeamListCell.h"

@interface TJTeamListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *teamTableView;

@end

@implementation TJTeamListViewController{
    dispatch_once_t onceToken;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"团队";
    [self.teamTableView setDelegate:self];
    [self.teamTableView setDataSource:self];
    
    
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
    //NSUInteger count = [_viewModel.projectList count];
    //return count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_once(&onceToken, ^{
        [tableView registerNib:[UINib nibWithNibName:@"TJTeamListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJTeamListCell"];
    });
    static NSString *cellId = @"TJTeamListCell";
    TJTeamListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    //TJProjectInfoModel *infoModel = (TJProjectInfoModel *)[_viewModel.projectList objectAtIndex:indexPath.row];
    //[cell setCellWithProjectItem:infoModel];
    
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
}


@end
