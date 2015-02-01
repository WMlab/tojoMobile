//
//  TJAdScrollCell.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJAdScrollCell.h"
#import "TJDefine.h"
#import <UIImageView+WebCache.h>
#import "TJSystemParam.h"

@interface TJAdScrollCell ()
@property (weak, nonatomic) IBOutlet MMScrollPresenter *mmScrollPresenter;

@end

@implementation TJAdScrollCell

- (void)awakeFromNib {
    CGRect rect = self.mmScrollPresenter.frame;
    rect.size.width = TJScreenWidth;
    self.mmScrollPresenter.frame = rect;
    
//    UIImageView *mountainImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mountains.jpg"]];
//    [mountainImage setFrame:CGRectMake(0, 0, self.mmScrollPresenter.frame.size.width, self.mmScrollPresenter.frame.size.height)];
//    
//    UIImageView *dockImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dock.jpg"]];
//    [dockImage setFrame:CGRectMake(0, 0, self.mmScrollPresenter.frame.size.width, self.mmScrollPresenter.frame.size.height)];
//    
//    UIImageView *forestImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forest.jpg"]];
//    [forestImage setFrame:CGRectMake(0, 0, self.mmScrollPresenter.frame.size.width, self.mmScrollPresenter.frame.size.height)];
    
//    MMScrollPage *firstPage = [[MMScrollPage alloc] init];
//    firstPage.titleLabel.text = @"Look a picture of mountains";
//    firstPage.detailLabel.text = @"I'm the detail text";
//    [firstPage.backgroundView addSubview:mountainImage];
//    firstPage.titleBackgroundColor = [UIColor colorWithRed:119/255.0f green:92/255.0f blue:166/255.0f alpha:0.5];
//    
//    MMScrollPage *secondPage = [[MMScrollPage alloc] init];
//    secondPage.titleLabel.text = @"Ooooh now look at the dock";
//    secondPage.detailLabel.text = @"I'm still the detail text! I'm useful!";
//    [secondPage.backgroundView addSubview:dockImage];
//    secondPage.titleBackgroundColor = [UIColor colorWithRed:67/255.0f green:89/255.0f blue:149/255.0f alpha:1.0];
//    
//    MMScrollPage *thirdPage = [[MMScrollPage alloc] init];
//    thirdPage.titleLabel.text = @"Now we're deep in a forest";
//    thirdPage.detailLabel.text = @"PAY ATTENTION TO ME";
//    [thirdPage.backgroundView addSubview:forestImage];
//    thirdPage.titleBackgroundColor = [UIColor colorWithRed:92/255.0f green:166/255.0f blue:114/255.0f alpha:1.0];
//    
//    [self.mmScrollPresenter setupViewsWithArray:@[firstPage, secondPage, thirdPage]];
//
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCellWithAdProjects:(NSArray *)projectArr {
    self.projectArr = projectArr;
    NSMutableArray *pageArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < projectArr.count; i++) {
        TJProjectInfoModel *model = (TJProjectInfoModel *)[projectArr objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mmScrollPresenter.frame.size.width, self.mmScrollPresenter.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, model.projectImage]]];
        
        MMScrollPage *page = [[MMScrollPage alloc] init];
        page.titleLabel.text = model.projectName;
        page.detailLabel.text = [NSString stringWithFormat:@"截止日期: %@", [model.projectEndDate substringWithRange:NSMakeRange(0, 10)]];
        page.detailLabel.textColor = TJColorHex(0x1ec399);
        [page.backgroundView addSubview:imageView];
        page.titleBackgroundColor = TJColorHex(0x373a3f);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProjectImage:)];
        [page.backgroundView addGestureRecognizer:tapGesture];
        page.backgroundView.tag = i;

        [pageArr addObject:page];
    }
    [self.mmScrollPresenter setupViewsWithArray:pageArr];
}

-(void)tapProjectImage:(UITapGestureRecognizer *) sender {
    TJProjectInfoModel *model = [_projectArr objectAtIndex:sender.view.tag];
    [_delegate selectProjectWithModel:model];
}


@end
