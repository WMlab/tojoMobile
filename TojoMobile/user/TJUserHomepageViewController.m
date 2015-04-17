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
#import "TJUserSender.h"

@interface TJUserHomepageViewController () {
    dispatch_once_t onceInfo;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 0;
    }
    else {
        return 0;
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
    else {
        return nil;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80.0;
    }
    else {
        return 40;
    }
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
-(void) setUserId:(int)userId
{
    _viewModel.userBasicInfo.userId = userId;
}
@end
