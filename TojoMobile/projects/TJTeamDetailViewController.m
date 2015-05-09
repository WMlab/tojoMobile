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
#import "TJMemberCollectionCell.h"
#import "TJUserBasicInfoModel.h"

@interface TJTeamDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) TJTeamDetailViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *memberCV;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *teamBasicInfoView;
@property (weak, nonatomic) IBOutlet UIView *teamActionView;
@property (weak, nonatomic) IBOutlet UIView *teamDetailView;
@property (weak, nonatomic) IBOutlet UIView *teamMemberView;

@property (weak, nonatomic) IBOutlet UIImageView *teamFounderImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamFounderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamOccupyInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamIntroLabel;

@property (weak, nonatomic) IBOutlet UILabel *teamMemberCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainTeamIntroViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainTeamMemberViewHeight;

@end

@implementation TJTeamDetailViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.viewModel = [[TJTeamDetailViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"团队详情";
    
//    self.memberCV.delegate = self;
//    self.memberCV.dataSource = self;
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
//    [self.memberCV registerClass:[TJMemberCollectionCell class] forCellWithReuseIdentifier:@"TJMemberCollectionCell"];
}

- (void)initView {
    [self.memberCV registerNib:[UINib nibWithNibName:@"TJMemberCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TJMemberCollectionCell"];
    UICollectionViewFlowLayout *cvLayout = [[UICollectionViewFlowLayout alloc] init];
    [cvLayout setItemSize:CGSizeMake(TJScreenWidth/3, 110)];
    cvLayout.minimumInteritemSpacing = 0;
    cvLayout.minimumLineSpacing = 0;
    self.memberCV.collectionViewLayout = cvLayout;
    
    [[TJProjectSender getInstance] sendGetTeamDetailWithViewModel:_viewModel completeBlock:^(BOOL success, NSString *message) {
        if (success) {
            //加载视图
            //teamBasicInfoView
            NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@", IMAGE_BASE_URL, _viewModel.team.teamFounderImage];
            [self.teamFounderImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
            self.teamFounderImageView.layer.cornerRadius = self.teamFounderImageView.bounds.size.height / 2;
            self.teamFounderImageView.layer.masksToBounds = YES;
            
            self.teamNameLabel.text = _viewModel.team.teamName;
            
            NSString *teamFounderInfoStr = [NSString stringWithFormat:@"创建者：%@ %@", _viewModel.team.teamFounderName, _viewModel.team.teamFounderSchool];
            self.teamFounderNameLabel.text = teamFounderInfoStr;

            NSString *teamOccupyInfoStr = [NSString stringWithFormat:@"人数：%d/%d", _viewModel.team.teamMemberNow, _viewModel.team.teamMemberAll];
            self.teamOccupyInfoLabel.text = teamOccupyInfoStr;
//            CGRect teamOccupyInfoLabelRect = [teamOccupyInfoStr boundingRectWithSize:CGSizeMake(MAXFLOAT, self.teamOccupyInfoLabel.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.teamOccupyInfoLabel.font} context:nil];
//            self.contrainTeamOccupyLabelWidth.constant = teamOccupyInfoLabelRect.size.width;
            int y = 0; //用于计算整个scrollView的长度
            NSString *teamIntroStr = _viewModel.team.teamDescription;
            self.teamIntroLabel.text = teamIntroStr;
            CGRect teamIntroLabelRect = [teamIntroStr boundingRectWithSize:CGSizeMake(self.teamIntroLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.teamOccupyInfoLabel.font} context:nil];
            self.constrainTeamIntroViewHeight.constant = teamIntroLabelRect.size.height + 50;
            y += self.teamDetailView.frame.origin.y + teamIntroLabelRect.size.height + 50;
            y += 11; //横线处的y坐标
            
            NSInteger teamMemberCount = _viewModel.teamMemberList.count;
            self.teamMemberCountLabel.text = [NSString stringWithFormat:@"%lu个队员", (unsigned long)teamMemberCount];
            
            int memberCVHeight = ceilf(teamMemberCount/3.0) * 110;
            self.constrainTeamMemberViewHeight.constant = self.memberCV.frame.origin.y + memberCVHeight;
            
            y += self.constrainTeamMemberViewHeight.constant;
            
            [self.scrollView setContentSize:CGSizeMake(TJScreenWidth, y)];
            
            [self.memberCV reloadData];
        }
    }];
}

#pragma mark - UICollectionView Datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.teamMemberList.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TJMemberCollectionCell *cell = (TJMemberCollectionCell *)[self.memberCV dequeueReusableCellWithReuseIdentifier:@"TJMemberCollectionCell" forIndexPath:indexPath];
    TJUserBasicInfoModel *memberModel = [_viewModel.teamMemberList objectAtIndex:indexPath.row];
    cell.memberNameLabel.text = memberModel.userRealName;
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@", IMAGE_BASE_URL,memberModel.userImage];
    [cell.memberImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    cell.memberImageView.layer.cornerRadius = cell.memberImageView.frame.size.height/2;
    cell.memberImageView.layer.masksToBounds = YES;

    return cell;
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
- (void)setTeamId:(NSString *)teamId {
    _viewModel.team.teamId = teamId;
}
@end
