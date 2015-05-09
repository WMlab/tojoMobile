//
//  TJVisitUserHomeTableViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserHomepageViewController.h"
#import "TJUserHomepageViewModel.h"
#import "TJUserBasicInfoCell.h"
#import "TJUserLabelCell.h"
#import "TJProjectListCell.h"
#import "TJUserSender.h"
#import "TJProjectDetailViewController.h"

@interface TJUserHomepageViewController () {
    dispatch_once_t onceInfo,onceLabel,onceProject;
}
@property (nonatomic, strong) TJUserHomepageViewModel *viewModel;
@end

@implementation TJUserHomepageViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        _viewModel = [[TJUserHomepageViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self sendGetUserDetailInfoRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 1;
    }
    else {
        return _viewModel.userProjectList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        dispatch_once(&onceInfo, ^{
            [tableView registerNib:[UINib nibWithNibName:@"TJUserBasicInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJUserBasicInfoCell"];});
        static NSString *cellId = @"TJUserBasicInfoCell";
        TJUserBasicInfoCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        [cell setCellWithModel:_viewModel.userBasicInfo];
        return cell;
    }
    else if (indexPath.section == 1){
        dispatch_once(&onceLabel, ^{
            [tableView registerNib:[UINib nibWithNibName:@"TJUserLabelCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJUserLabelCell"];});
        static NSString *cellId = @"TJUserLabelCell";
        TJUserLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        [cell setCellWithLabels:_viewModel.userLabelArr];
        return cell;
    }
    else {
        dispatch_once(&onceProject, ^{
            [tableView registerNib:[UINib nibWithNibName:@"TJProjectListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJProjectListCell"];
        });
        static NSString *cellId = @"TJProjectListCell";
        TJProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        TJProjectInfoModel *infoModel = (TJProjectInfoModel *)[_viewModel.userProjectList objectAtIndex:indexPath.row];
        [cell setCellWithProjectItem:infoModel];
        return cell;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 170.0;
    }
    else if (indexPath.section == 1) {
        return [TJUserLabelCell getCellHeightWithLabels:_viewModel.userLabelArr];
    }
    else if (indexPath.section == 2){
        return 130;
    }
    else {
        return 40;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, TJScreenWidth, 20)];
    secView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:secView.frame];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [secView addSubview:titleLabel];

    if (section == 1) {
        if (_viewModel.userBasicInfo.userGender == 0) {
            titleLabel.text = @"她的标签";
        }
        else {
            titleLabel.text = @"他的标签";
        }
        return secView;
    }
    else if (section == 2) {
        if (_viewModel.userBasicInfo.userGender == 0) {
            titleLabel.text = @"她的项目";
        }
        else {
            titleLabel.text = @"他的项目";
        }
        return secView;
    }
    else {
        return nil;
    }
}


#pragma mark - tableview delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        TJProjectDetailViewController *detailViewController = [[TJProjectDetailViewController alloc] init];
        TJProjectInfoModel *projectModel = [_viewModel.userProjectList objectAtIndex:indexPath.row];
        [detailViewController setProjectId:projectModel.projectId];
        detailViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark --------发服务 --------
-(void) sendGetUserDetailInfoRequest {
    [[TJUserSender getInstance] sendGetUserDetailInfoWithViewModel:_viewModel completeBlock:^(BOOL success, NSString *message) {
        if (success) {
            [self.tableView reloadData];
        } else {
            
        }
    }];
}

#pragma mark --------属性相关--------
-(void) setUserId:(NSString *)userId
{
    _viewModel.userBasicInfo.userId = userId;
}
@end
