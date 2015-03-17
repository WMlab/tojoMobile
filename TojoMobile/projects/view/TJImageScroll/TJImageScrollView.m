//
//  TJImageScrollView.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJImageScrollView.h"
#import "TJDefine.h"
#import <Masonry.h>

static int titleViewHeight = 75;
static int pageViewPadding = 20;

@interface TJImageScrollView()

@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) NSMutableArray *pageArray;
@property (strong, nonatomic) UIScrollView *titleScrollView;
@property (strong, nonatomic) UIScrollView *labelScrollView;
@property (strong, nonatomic) NSMutableArray *labelScrollViewArray;

@property CGRect backgroundFrame;

@property CGRect titleViewFrame;
@property CGRect titleLabelFrame;
@property CGRect titleDetailLabelFrame;
@property CGRect iconFrame;

@end

@implementation TJImageScrollView

-(void)addTJScrollPage:(TJScrollPage *)page
{
    if(self.pageArray == nil)
    {
        [self setupScrollPresenter];
    }
    
    [self.pageArray addObject:page];
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(TJScrollPage *page in self.pageArray)
    {
        [[page.titleView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self setupViews];
}

-(void)setupViewsWithArray:(NSMutableArray *)array
{
    [self setupScrollPresenter];
    
    self.pageArray = array;
    
    [self setupViews];
}

-(void)setupScrollPresenter
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.delegate = self;
    self.bounces = NO;
    
    self.pageArray = [[NSMutableArray alloc] init];
    self.labelScrollViewArray = [[NSMutableArray alloc] init];
}

-(void)setupViews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    for (UIView *subview in self.superview.subviews) {
        if ([subview isKindOfClass:[UIPageControl class]]) {
            [subview removeFromSuperview];
        }
    }
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(160, self.frame.size.height - 45, 40, 37)];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.pageArray.count;
    [self.superview addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.superview);
        make.size.mas_equalTo(CGSizeMake(40, 37));
        make.bottom.equalTo(self.superview).with.offset(-5);
    }];
    
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - titleViewHeight, self.frame.size.width * [self.pageArray count], titleViewHeight)];
    self.titleScrollView.contentSize = CGSizeMake(self.frame.size.width * [self.pageArray count], titleViewHeight);
    [self addSubview:self.titleScrollView];
    
    int pageArrayIndex = 0;
    
    for (TJScrollPage *page in self.pageArray)
    {
        self.backgroundFrame = CGRectMake(self.frame.size.width * pageArrayIndex, 0, self.frame.size.width, self.frame.size.height);
        
        self.titleViewFrame = CGRectMake(self.frame.size.width * pageArrayIndex, 0, self.backgroundFrame.size.width, titleViewHeight);
        
        [page.backgroundView setFrame:self.backgroundFrame];
        [self addSubview:page.backgroundView];
        [self sendSubviewToBack:page.backgroundView];
        
        [page.titleView setFrame:self.titleViewFrame];
        
        CGRect titleLabelFrame = CGRectMake(10, titleViewHeight / 100, page.titleView.frame.size.width - pageViewPadding, titleViewHeight / 1.7);
        page.titleLabel.frame = titleLabelFrame;
        
        CGRect titleDetailLabelFrame = CGRectMake(10, titleViewHeight / 2.2, page.titleView.frame.size.width - pageViewPadding, titleViewHeight / 2);
        page.detailLabel.frame = titleDetailLabelFrame;
        
        self.labelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, page.titleView.frame.size.width, page.titleView.frame.size.height)];
        [page.titleView addSubview:self.labelScrollView];
        
        UIView *titleViewBackground = [[UIView alloc] initWithFrame:self.labelScrollView.frame];
        titleViewBackground.alpha = 0.5;
        [titleViewBackground setBackgroundColor:page.titleBackgroundColor];
        [page.titleView addSubview:titleViewBackground];
        [page.titleView sendSubviewToBack:titleViewBackground];
        
        [self.labelScrollView addSubview:page.detailLabel];
        [self.labelScrollView addSubview:page.titleLabel];
        
        [self.titleScrollView addSubview:page.titleView];
        
        [self.labelScrollViewArray addObject:self.labelScrollView];
        
        pageArrayIndex++;
    }
    
    self.contentSize = CGSizeMake(self.frame.size.width * self.pageArray.count, self.frame.size.height);
}

-(int)currentPage
{
    return self.contentOffset.x / self.frame.size.width;
}

-(void)animateToPageAtIndex:(int)index
{
    [self setContentOffset:CGPointMake(self.frame.size.width * index, self.contentOffset.y) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
//    
//    [self.titleScrollView setContentOffset:CGPointMake(scrollView.contentOffset.x * -(xOffset / self.frame.size.width), scrollView.contentOffset.y) animated:NO];
//    
//    for(UIScrollView *labelScrollView in self.labelScrollViewArray)
//    {
//        [labelScrollView setContentOffset:CGPointMake(scrollView.contentOffset.x * (xOffset / self.frame.size.width), scrollView.contentOffset.y) animated:NO];
//    }
//}

@end
