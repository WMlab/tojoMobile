//
//  TJAppHomeViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJAppHomeViewController.h"
#import "TJFourProjectCell.h"
#import "TJHeaderCell.h"
#import <MJRefresh.h>
#import "TJAppHomeSender.h"
#import "TJProjectDetailViewController.h"

@interface TJAppHomeViewController ()<TJFourProjectDelegate>
{
    dispatch_once_t onceAd,onceProject,onceTitle,refreshAfterLaunch;
}
@property (nonatomic, strong) TJAppHomeViewModel *viewModel;
@end

@implementation TJAppHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_once(&refreshAfterLaunch, ^{
        [self performSelector:@selector(refreshAfterAppear) withObject:nil afterDelay:1.0f];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    //定义上拉、下拉加载数据
    [self updateDataSource];
}

- (void)initData {
    if (!_viewModel) {
        _viewModel = [[TJAppHomeViewModel alloc] init];
    }
//    [self loadLastRecordData];
}

- (void)refreshAfterAppear {
    //打开程序自动下拉刷新页面
    [self.tableView headerBeginRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        //最上面的滚动展示cell
//        dispatch_once(&onceAd, ^{
//            [tableView registerNib:[UINib nibWithNibName:@"TJAdScrollCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJAdScrollCell"];});
////        static NSString *cellId = @"TJAdScrollCell";
////        TJAdScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
////        cell.delegate = self;
////        [cell setCellWithAdProjects:_viewModel.adProjectList];
////        return cell;
//    }
//    else if(indexPath.row % 2 == 1 ){
//        //每种项目的标题cell
//        dispatch_once(&onceTitle, ^{
//            [tableView registerNib:[UINib nibWithNibName:@"TJHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJHeaderCell"];
//        });
//        static NSString *cellId = @"TJHeaderCell";
//        TJHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        switch (indexPath.row) {
//            case 1:
//                cell.projectTypeLabel.text = @"精选";
//                break;
//            case 3:
//                cell.projectTypeLabel.text = @"热门";
//                break;
//            case 5:
//                cell.projectTypeLabel.text = @"最新";
//                break;
//            default:
//                break;
//        }
//        return cell;
//    }
//    else {
//        //项目的cell，4合1
//        dispatch_once(&onceProject, ^{
//            [tableView registerNib:[UINib nibWithNibName:@"TJFourProjectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJFourProjectCell"];
//        });
//        static NSString *cellId = @"TJFourProjectCell";
//        TJFourProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        cell.delegate = self;
//        switch (indexPath.row) {
//            case 2:
//                [cell setCellWithProjects:_viewModel.selectedProjectList];
//                break;
//            case 4:
//                [cell setCellWithProjects:_viewModel.hottestProjectList];
//                break;
//            case 6:
//                [cell setCellWithProjects:_viewModel.latestProjectList];
//                break;
//            default:
//                break;
//        }
//
//        return cell;
//    }
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 270;
    }
    else if (indexPath.row % 2 == 1) {
        return 33;
    }
    else {
        return 255;
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

#pragma mark --------- TJFourProjectDelegate -----------
-(void)selectProjectWithModel:(TJProjectInfoModel *)model {
    TJProjectDetailViewController *detailViewController = [[TJProjectDetailViewController alloc] init];
    detailViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark --------- 发服务 -----------
-(void) loadAppHomeData
{
    [[TJAppHomeSender getInstance] sendGetAppHomeDataWithViewModel:_viewModel andUserId:2 completeBlock:^(BOOL success, NSString *message) {
        [self.tableView headerEndRefreshing];
        if (success) {
            NSLog(@"success");
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [self saveRecordToDataBase];
//            });
            [self.tableView reloadData];
        }
        else {
            NSLog(@"falied");
        }
    }];
}


//定义上拉下拉刷新数据的方法。
- (void)updateDataSource
{
    __block TJAppHomeViewController *appHomeVc = self;
    
    //下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [appHomeVc loadAppHomeData];
    }];
}


@end
