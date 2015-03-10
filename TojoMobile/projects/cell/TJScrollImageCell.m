//
//  TJScrollImageCell.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJScrollImageCell.h"
#import "TJDefine.h"
#import "TJProjectInfoModel.h"
#import "TJSystemParam.h"
#import <UIImageView+WebCache.h>
#import "TJImageScrollView.h"
#import "TJScrollPage.h"

@interface TJScrollImageCell () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet TJImageScrollView *imageScrollView;

@property (nonatomic, strong) NSArray *projectList;
@end

@implementation TJScrollImageCell

- (void)awakeFromNib {
    // Initialization code
    CGRect rect = self.imageScrollView.frame;
    rect.size.width = TJScreenWidth;
    self.imageScrollView.frame = rect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCellWithAdProjects:(NSArray *)projectArr
{
    _projectList = projectArr;
    
    NSMutableArray *pageArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < projectArr.count; i++) {
        TJProjectInfoModel *model = (TJProjectInfoModel *)[projectArr objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, model.projectImage]]];
        
        TJScrollPage *page = [[TJScrollPage alloc] init];
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
    [self.imageScrollView setupViewsWithArray:pageArr];
}

-(void)tapProjectImage:(UITapGestureRecognizer *) sender {
    [_delegate selectPageNumber:sender.view.tag];    
}

@end
