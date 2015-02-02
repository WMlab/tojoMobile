//
//  TJProjectHomeViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/2/1.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectHomeViewController.h"
#import "TJProjectCategoryHead.h"
#import "TJAdScrollCell.h"
#import <MJRefresh.h>
#import "TJProjectCategoryModel.h"
#import "TJDefine.h"

@interface TJProjectHomeViewController () <UITableViewDelegate, UITableViewDataSource>
{
    dispatch_once_t onceAd,refreshAfterLaunch;
}
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
//        [self performSelector:@selector(refreshAfterAppear) withObject:nil afterDelay:1.0f];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    [self loadCategoryData];
    //    if (!_viewModel) {
    //        _viewModel = [[TJAppHomeViewModel alloc] init];
    //    }
    //    [self loadLastRecordData];
}

- (void)initView {
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
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //最上面的滚动展示cell
        dispatch_once(&onceAd, ^{
            [tableView registerNib:[UINib nibWithNibName:@"TJAdScrollCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJAdScrollCell"];});
        static NSString *cellId = @"TJAdScrollCell";
        TJAdScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        [cell setCellWithAdProjects:_viewModel.adProjectList];
        return cell;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 270;
    }
    else {
        return 130;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    TJProjectCategoryHead *headView = [[TJProjectCategoryHead alloc] init];
//    return headView;
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30;
//}
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

- (void)loadCategoryData {
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"projectCategory" withExtension:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfURL:plistUrl];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (int i=0; i<arr.count; i++) {
        TJProjectCategoryModel *model = [[TJProjectCategoryModel alloc] init];
        NSDictionary *dic = [arr objectAtIndex:i];
        model.catId = [[dic objectForKey:@"catId"] intValue];
        model.labelId = [[dic objectForKey:@"labelId"] intValue];
        model.catName = [dic objectForKey:@"catName"];
        [tempArr addObject:model];
    }
    _catArr = [tempArr copy];
}

//定义上拉下拉刷新数据的方法。
- (void)updateDataSource
{
//    __block TJProjectHomeViewController *appHomeVc = self;
    
    //下拉刷新
    [self.projectTableView addHeaderWithCallback:^{
//        [appHomeVc loadAppHomeData];
    }];
}

@end
