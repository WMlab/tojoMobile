//
//  TJProjectInfoViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/18.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectInfoViewController.h"
#import "TJSystemParam.h"

@interface TJProjectInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *projectInfoTableView;
@property (strong, nonatomic) IBOutlet UIView *projectInfoView;
@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel *projectCreatedDate;
@property (weak, nonatomic) IBOutlet UILabel *projectFounderName;
@property (weak, nonatomic) IBOutlet UIImageView *projectImage;
@property (weak, nonatomic) IBOutlet UILabel *projectText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *projectTextHeight;


@end

@implementation TJProjectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.title = @"介绍";
    
    self.projectInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.projectInfoTableView.tableHeaderView = _projectInfoView;
    //self.projectInfoTableView.backgroundColor = RGBColor(245.0f, 245.0f, 245.0f);
    
    [self loadProjectInfoView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 载入数据

-(void)loadProjectInfoView{
    CGFloat otherHeight = 450.0f;
    
    UIView * tableHeaderView = self.projectInfoView;
    
    
    //项目文本处理
    NSString *labelStr = @"我自己理解，「互联网本身是思维」，再延伸一句话，「互联网也是肉体」，要想跑得快你必须具备互联网的思维、互联网的肉体，但是你要想跑得久你需要灵魂，这个灵魂其实是对于传统业务的专业能力的把握和理解，这在电商，在比如互联网金融、互联网汽车等很多领域都是这样，一句话概括就是「别让肉体跑丢了灵魂，请保持对互联网的敬畏」当我们进入这些产业的时候，他们对这些产业的掌握、理解、能力、执行都是需要我们学习的。我自己理解，「互联网本身是思维」，再延伸一句话，「互联网也是肉体」，要想跑得快你必须具备互联网的思维、互联网的肉体，但是你要想跑得久你需要灵魂，这个灵魂其实是对于传统业务的专业能力的把握和理解，这在电商，在比如互联网金融、互联网汽车等很多领域都是这样，一句话概括就是「别让肉体跑丢了灵魂，请保持对互联网的敬畏」当我们进入这些产业的时候，他们对这些产业的掌握、理解、能力、执行都是需要我们学习的。";

    self.projectText.text = labelStr;
    CGSize projectTextSize = [self.projectText.text sizeWithFont:self.projectText.font constrainedToSize:CGSizeMake(TJScreenWidth-30.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    self.projectTextHeight.constant = ceilf(projectTextSize.height);
    
    tableHeaderView.frame = CGRectMake(self.projectInfoView.frame.origin.x, self.projectInfoView.frame.origin.y, self.projectInfoView.frame.size.width, ceilf(projectTextSize.height)+otherHeight);
    self.projectInfoView = tableHeaderView;
    self.projectInfoTableView.tableHeaderView = self.projectInfoView;
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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击团队
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
