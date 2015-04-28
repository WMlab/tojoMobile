//
//  TJProjectHomeViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/2/1.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectHomeViewController.h"
#import "TJProjectCategoryHead.h"
#import <MJRefresh.h>
#import "TJProjectCategoryModel.h"
#import "TJDefine.h"
#import "TJProjectHomeViewModel.h"
#import "TJProjectSender.h"
#import "TJProjectListCell.h"
#import "TJProjectDetailViewController.h"
#import "TJScrollImageCell.h"

@interface TJProjectHomeViewController () <UITableViewDelegate, UITableViewDataSource, TJScrollImageDelegate>
{
    dispatch_once_t onceAd,onceList,refreshAfterLaunch;
}
@property (strong, nonatomic) TJProjectHomeViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *projectTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *catScrollView;

@property (nonatomic, strong) NSArray *catArr;
@end

@implementation TJProjectHomeViewController

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

- (void)initData {
    [self loadCategoryData];
    if (!_viewModel) {
        _viewModel = [[TJProjectHomeViewModel alloc] init];
    }
    TJProjectCategoryModel *model = [_catArr objectAtIndex:0];
    _viewModel.categoryId = model.categoryId;
    _viewModel.customId = model.customId;
    //    [self loadLastRecordData];
}

- (void)initView {
    //tableview上方滑动分类选择视图
    [self setupCatScrollView];
    //定义上拉、下拉加载数据
    [self updateDataSource];
}

- (void)refreshAfterAppear {
    //打开程序自动下拉刷新页面
    [self.projectTableView headerBeginRefreshing];
}

- (void)setupCatScrollView {
    //空白view
//    CGFloat btnWidth = 50;
    NSUInteger catNum = _catArr.count;
    CGFloat xPos = 0;
    for (int i = 0; i < catNum; i++) {
        TJProjectCategoryModel *model = [_catArr objectAtIndex:i];
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(xPos, 0, 20, 30)];
        spaceView.backgroundColor = [UIColor whiteColor];
        [_catScrollView addSubview:spaceView];
        xPos += 20;
        
        UIFont *font = [UIFont systemFontOfSize:16];
        CGRect rect = [model.catName boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        CGFloat width = rect.size.width;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 0, width, 30)];
        btn.tag = i;
        [btn setTitle:model.catName forState:UIControlStateNormal];
        if (i == 0) {
            [btn setTitleColor:TJColorHex(0x1ec399) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        else {
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(changeCategory:) forControlEvents:UIControlEventTouchUpInside];
        [_catScrollView addSubview:btn];
        xPos += width;
    }
    _catScrollView.contentSize = CGSizeMake(xPos, 30);
    _catScrollView.showsHorizontalScrollIndicator = false;
}

- (void) changeCategory:(UIButton *) sender {
    for (UIView *subview in _catScrollView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
    [sender setTitleColor:TJColorHex(0x1ec399) forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:16];
    //根据分类选择更新viewmodel
    TJProjectCategoryModel *model = [_catArr objectAtIndex:sender.tag];
    _viewModel.categoryId = model.categoryId;
    _viewModel.customId = model.customId;

    //切换分类后，自动下拉刷新更新数据
    [self.projectTableView headerBeginRefreshing];
}
#pragma mark - image scrollview delegate
-(void) selectPageNumber:(NSInteger) index {
    TJProjectInfoModel *infoModel = [_viewModel.adProjects objectAtIndex:index];
    [self goToDetailViewWithProjectId:infoModel.projectId];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger rowCount = 0;
    if ([self hasAdProjects]) {
        rowCount ++;
    }
    return rowCount + _viewModel.projectList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && [self hasAdProjects]) {
        //最上面的滚动展示cell
        dispatch_once(&onceAd, ^{
            [tableView registerNib:[UINib nibWithNibName:@"TJScrollImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJScrollImageCell"];});
        static NSString *cellId = @"TJScrollImageCell";
//        TJAdScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        TJScrollImageCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.delegate = self;
        [cell setCellWithAdProjects:_viewModel.adProjects];
        return cell;
    }
    else {
        dispatch_once(&onceList, ^{
            [tableView registerNib:[UINib nibWithNibName:@"TJProjectListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJProjectListCell"];
        });
        static NSString *cellId = @"TJProjectListCell";
        TJProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        TJProjectInfoModel *infoModel = (TJProjectInfoModel *)[_viewModel.projectList objectAtIndex:indexPath.row - [self hasAdProjects]];
        [cell setCellWithProjectItem:infoModel];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if ([self hasAdProjects]) {
            return 240;
        } else {
            return 130;
        }
    }
    else {
        return 130;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TJProjectInfoModel *infoModel = nil;
    if (indexPath.row == 0 && [self hasAdProjects]) {
        infoModel = [_viewModel.projectList objectAtIndex:0];
    }
    else {
        infoModel = (TJProjectInfoModel *)[_viewModel.projectList objectAtIndex:indexPath.row - [self hasAdProjects]];
    }
    
    [self goToDetailViewWithProjectId:infoModel.projectId];
}

- (void) goToDetailViewWithProjectId:(int) projectId {
    TJProjectDetailViewController *detailViewController = [[TJProjectDetailViewController alloc] init];
    [detailViewController setProjectId:projectId];
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --------- 发服务 -----------
-(void) getProjectHomeData
{
    [[TJProjectSender getInstance] sendGetProjectHomeDataWithViewModel:_viewModel completeBlock:^(BOOL success, NSString *message) {
        [self.projectTableView headerEndRefreshing];
        if (success) {
            NSLog(@"success");
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////                [self saveRecordToDataBase];
//            });
            [self.projectTableView reloadData];
        }
        else {
            [self.projectTableView reloadData];
            NSLog(@"falied");
        }
    }];
}


- (void)loadCategoryData {
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"projectCategory" withExtension:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfURL:plistUrl];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (int i=0; i<arr.count; i++) {
        TJProjectCategoryModel *model = [[TJProjectCategoryModel alloc] init];
        NSDictionary *dic = [arr objectAtIndex:i];
        model.categoryId = [[dic objectForKey:@"categoryId"] intValue];
        model.customId = [[dic objectForKey:@"customId"] intValue];
        model.catName = [dic objectForKey:@"catName"];
        [tempArr addObject:model];
    }
    _catArr = [tempArr copy];
}

//定义上拉下拉刷新数据的方法。
- (void)updateDataSource
{
    __block TJProjectHomeViewController *projectHomeVc = self;
    
    //下拉刷新
    [self.projectTableView addHeaderWithCallback:^{
        [projectHomeVc getProjectHomeData];
    }];
}

- (BOOL) hasAdProjects {
    return !(_viewModel.adProjects.count==0);
}

@end
