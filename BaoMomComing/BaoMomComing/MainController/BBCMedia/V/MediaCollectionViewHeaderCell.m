//
//  MediaCollectionViewHeaderCell.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaCollectionViewHeaderCell.h"

@interface MediaCollectionViewHeaderCell ()<CycleScrollViewDelegate>

@property (strong, nonatomic)  CycleScrollView *mediaCycleScroll;
@property (strong, nonatomic)  UIPageControl *pageControl;
@property (strong, nonatomic)  UIView *menuBackView;
@property (strong, nonatomic)  UIView *cutView;

@property (nonatomic, strong)  NSMutableArray *dataArr;

@end

@implementation MediaCollectionViewHeaderCell

- (void)awakeFromNib {
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadAllMenuView];
    }
    return self;
}

#pragma mark - **************************** 配置滚动视图 *************************************
- (void)setMediaHeaderCellWithDataArr:(NSMutableArray *)dataArrM{
    self.dataArr = dataArrM;
    self.pageControl.numberOfPages = dataArrM.count;
    
    CGFloat width = self.mediaCycleScroll.width;
    CGFloat height = self.mediaCycleScroll.height;
    
    __block NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    if (dataArrM.count == 1) {
        
        NSDictionary *dict = [dataArrM firstObject];
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            [imageView sd_setImageWithURL:IMAGE_URL_Media([dict objectForKey:@"logo2_phone"]) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
            [viewArray addObject:imageView];
        }
        
    }else if (dataArrM.count == 2) {
        
        for (int i = 0; i < 4; i++) {
            NSDictionary *dict = [dataArrM objectAtIndex:i%2];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            [imageView sd_setImageWithURL:IMAGE_URL_Media([dict objectForKey:@"logo2_phone"]) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
            [viewArray addObject:imageView];
        }
        
    }else {
        
        for (int i = 0; i < dataArrM.count; i++) {
            NSDictionary *dict = dataArrM[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            [imageView sd_setImageWithURL:IMAGE_URL_Media([dict objectForKey:@"logo2_phone"]) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
            [viewArray addObject:imageView];
        }
        
    }
    
    //进行scrollView数据配置
    self.mediaCycleScroll.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewArray[pageIndex];
    };
    self.mediaCycleScroll.totalPagesCount = ^NSInteger(void){
        return viewArray.count;
    };
    
    __block UIPageControl *control = _pageControl;
    self.mediaCycleScroll.getCurrentPage = ^(NSInteger pageIndex){
        NSInteger index = 0;
        if (dataArrM.count == 1) {
            index = 0;
        }else if (dataArrM.count == 2) {
            index = pageIndex % 2;
        }else {
            index = pageIndex;
        }
        control.currentPage = index;
    };
}

#pragma mark - **************************** cycleScrollView方法 *************************************
- (void)tapActionWithPageIndex:(NSInteger)pageIndex {
    NSInteger index = 0;
    if (self.dataArr.count == 1) {
        index = 0;
    }else if (self.dataArr.count == 2) {
        index = pageIndex % 2;
    }else {
        index = pageIndex;
    }
    if (index == 1) {
        
    }
    
    NSDictionary *dict = [self.dataArr objectAtIndex:index];
    int type = [[dict objectForKey:@"type"] intValue];
    if (type == 3){
        NSURL *url = [NSURL URLWithString:[dict objectForKey:@"url"]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    else if(type == 1){
        XJMediaDetailViewController *mediaDeail = [[XJMediaDetailViewController alloc] init];
        mediaDeail.mediaID = [dict objectForKey:@"param"];
        [[self viewController] presentViewController:mediaDeail animated:YES completion:nil];
    }else{
        [MANAGER_SHOW showInfo:@"因版权原因，该视频暂时无法播放！"];
    }
    
}

#pragma mark - **************************** 控件方法 *************************************
/**
 *  视频菜单选项操作
 *
 *  @param sender 八个button事件
 */
- (void)userClickAction:(id)sender {
    switch (self.tag) {
        case 1://宝妈课堂
        {
            
        }
            break;
        case 2://热推荐
        {
            
        }
            break;
        case 3://自频道
        {
            
        }
            break;
        case 4://宝妈直播
        {
            
        }
            break;
        case 5://会员专享
        {
            
        }
            break;
        case 6://礼物
        {
            
        }
            break;
        case 7://最爱
        {
            
        }
            break;
        case 8://下载
        {
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - **************************** 懒加载 *************************************
- (CycleScrollView *)mediaCycleScroll{
    if (_mediaCycleScroll == nil) {
        _mediaCycleScroll = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width*0.5) animationDuration:3];
        _mediaCycleScroll.delegate = self;
        [self.contentView addSubview:_mediaCycleScroll];
    }
    return _mediaCycleScroll;
}

- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPageIndicatorTintColor = ALLBACK_COLOR;
        [self.mediaCycleScroll addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIView *)menuBackView{
    if (_menuBackView == nil) {
        _menuBackView = [[UIView alloc] init];
        [self.contentView addSubview:_menuBackView];
    }
    return _menuBackView;
}

- (UIView *)cutView{
    if (_cutView == nil) {
        _cutView = [[UIView alloc] init];
        _cutView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_cutView];
    }
    return _cutView;
}

- (void)loadAllMenuView{
    for (int i=1;i<=8 ; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mediaMenu%d",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [self.menuBackView addSubview:btn];
        UILabel *lab = [[UILabel alloc] init];
        if (i == 1) {
            lab.text = @"宝妈课堂";
        }
        else if(i == 2){
            lab.text = @"热推荐";
        }else if(i == 3){
            lab.text = @"自频道";
        }else if(i == 4){
            lab.text = @"宝妈直播";
        }else if(i == 5){
            lab.text = @"会员专享";
        }else if(i == 6){
            lab.text = @"礼物";
        }else if(i == 7){
            lab.text = @"最爱";
        }else{
            lab.text = @"下载管理";
        }
        lab.textColor = [UIColor darkGrayColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.tag = 10+i;
        [self.menuBackView addSubview:lab];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.frame = CGRectMake(0, self.mediaCycleScroll.height-30, self.mediaCycleScroll.width, 37);
    self.menuBackView.frame = CGRectMake(0, self.mediaCycleScroll.bottom, self.mediaCycleScroll.width, 150);
    
    for (int i=1; i<=8; i++) {
        UIButton *btn = (UIButton*)[self.menuBackView viewWithTag:i];
        if (i<=4) {
            btn.frame = CGRectMake((self.menuBackView.width-160)*0.2*i+((i-1)*40), 10, 40, 40);
        }else if(5<=i&&i<8){
            btn.frame = CGRectMake((self.menuBackView.width-160)*0.2*(i%4)+((i%4-1)*40), 80, 40, 40);
        }else{
            btn.frame = CGRectMake((self.menuBackView.width-160)*0.2*(i/2)+((i/2-1)*40), 80, 40, 40);
        }
        
        UILabel *lab = (UILabel*)[self.menuBackView viewWithTag:10+i];
        if (i<=4) {
            lab.frame = CGRectMake(btn.left-7, btn.bottom+4, 55, 16);
        }else if(5<=i&&i<8){
            lab.frame = CGRectMake(btn.left-7, btn.bottom+4, 55, 16);
        }else{
            lab.frame = CGRectMake(btn.left-7, btn.bottom+4, 55, 16);
        }
    }
    
    self.cutView.frame = CGRectMake(0, self.menuBackView.bottom, self.mediaCycleScroll.width, 5);
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
