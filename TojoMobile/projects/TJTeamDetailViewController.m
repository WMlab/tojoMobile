//
//  TJTeamDetailViewController.m
//  TojoMobile
//
//  Created by sdq on 15/2/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTeamDetailViewController.h"
#import "TJTeamDetailViewModel.h"
#import "TJProjectSender.h"
#import <UIImageView+WebCache.h>

@interface TJTeamDetailViewController ()

@property (strong, nonatomic) TJTeamDetailViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIView *teamBasicInfoView;
@property (weak, nonatomic) IBOutlet UIView *teamActionView;
@property (weak, nonatomic) IBOutlet UIView *teamDetailView;
@property (weak, nonatomic) IBOutlet UIView *teamMemberView;

@property (weak, nonatomic) IBOutlet UIImageView *teamFounderImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamFounderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamOccupyInfoLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainTeamNameLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainTeamFounderLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contrainTeamOccupyLabelWidth;

@end

@implementation TJTeamDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"团队详情";
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    _viewModel = [[TJTeamDetailViewModel alloc] init];
}

- (void)initView {
    [[TJProjectSender getInstance] sendGetTeamDetailWithViewModel:_viewModel completeBlock:^(BOOL success, NSString *message) {
        if (success) {
            //加载视图
            //teamBasicInfoView
            NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@", IMAGE_BASE_URL, _viewModel.team.teamFounderImage];
            [self.teamFounderImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
            self.teamFounderImageView.layer.cornerRadius = self.teamFounderImageView.bounds.size.height / 2;
            self.teamFounderImageView.layer.masksToBounds = YES;
            
            self.teamNameLabel.text = _viewModel.team.teamName;
            CGRect teamNameLabelRect = [_viewModel.team.teamName boundingRectWithSize:CGSizeMake(MAXFLOAT, self.teamNameLabel.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.teamNameLabel.font} context:nil];
            self.constrainTeamNameLabelWidth.constant = teamNameLabelRect.size.width;
            
            NSString *teamFounderInfoStr = [NSString stringWithFormat:@"创建者：%@ %@", _viewModel.team.teamFounderName, _viewModel.team.teamFounderSchool];
            self.teamFounderNameLabel.text = teamFounderInfoStr;
            CGRect teamFounderNameLabelRect = [teamFounderInfoStr boundingRectWithSize:CGSizeMake(MAXFLOAT, self.teamFounderNameLabel.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.teamFounderNameLabel.font} context:nil];
            self.constrainTeamFounderLabelWidth.constant = teamFounderNameLabelRect.size.width;

            NSString *teamOccupyInfoStr = [NSString stringWithFormat:@"人数：%d/%d", _viewModel.team.teamMemberNow, _viewModel.team.teamMemberAll];
            self.teamOccupyInfoLabel.text = teamOccupyInfoStr;
            CGRect teamOccupyInfoLabelRect = [teamOccupyInfoStr boundingRectWithSize:CGSizeMake(MAXFLOAT, self.teamOccupyInfoLabel.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.teamOccupyInfoLabel.font} context:nil];
            self.contrainTeamOccupyLabelWidth.constant = teamOccupyInfoLabelRect.size.width;
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -------- 属性相关 --------
- (void)setTeamId:(int)teamId {
    _viewModel.team.teamId = teamId;
}
@end
