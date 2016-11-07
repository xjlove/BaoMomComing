//
//  MediaCollectionViewHeaderCell.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaCollectionViewHeaderCell.h"

@interface MediaCollectionViewHeaderCell ()<CycleScrollViewDelegate>{
    CycleScrollView *mediaCycleScroll;
}

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (strong, nonatomic) IBOutlet UIImageView *scrollBackImg;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIView *menuBackView;
@property (strong, nonatomic) IBOutlet UIView *cutView;

@end

@implementation MediaCollectionViewHeaderCell

- (void)awakeFromNib {
    [self loadScrollview];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)loadScrollview{
    mediaCycleScroll = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.5) animationDuration:3];
    mediaCycleScroll.delegate = self;
    
    [self.contentView addSubview:mediaCycleScroll];
    
    [self.contentView bringSubviewToFront:_pageControl];

}

- (void)setMediaHeaderCellWithDataArr:(NSMutableArray *)dataArrM{
    if (dataArrM.count == 0) {
        self.scrollBackImg.hidden = NO;
    }else{
        self.scrollBackImg.hidden = YES;
    }
    self.dataArr = dataArrM;
    self.pageControl.numberOfPages = dataArrM.count;
    
    CGFloat width = mediaCycleScroll.frame.size.width;
    CGFloat height = mediaCycleScroll.frame.size.height;
    
    __block NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    if (dataArrM.count == 1) {
        
        NSDictionary *dict = [dataArrM firstObject];
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            [imageView sd_setImageWithURL:IMAGE_URL([dict objectForKey:@"logo2_phone"]) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
            [viewArray addObject:imageView];
        }
        
    }else if (dataArrM.count == 2) {
        
        for (int i = 0; i < 4; i++) {
            NSDictionary *dict = [dataArrM objectAtIndex:i%2];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            [imageView sd_setImageWithURL:IMAGE_URL([dict objectForKey:@"logo2_phone"]) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
            [viewArray addObject:imageView];
        }
        
    }else {
        
        for (int i = 0; i < dataArrM.count; i++) {
            NSDictionary *dict = dataArrM[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            [imageView sd_setImageWithURL:IMAGE_URL([dict objectForKey:@"logo2_phone"]) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
            [viewArray addObject:imageView];
        }
        
    }
    
    //进行scrollView数据配置
    mediaCycleScroll.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewArray[pageIndex];
    };
    mediaCycleScroll.totalPagesCount = ^NSInteger(void){
        return viewArray.count;
    };
    
    __block UIPageControl *control = _pageControl;
    mediaCycleScroll.getCurrentPage = ^(NSInteger pageIndex){
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

#pragma mark - CycleScrollViewDelegate
- (void)tapActionWithPageIndex:(NSInteger)pageIndex {
    NSInteger index = 0;
    if (self.dataArr.count == 1) {
        index = 0;
    }else if (self.dataArr.count == 2) {
        index = pageIndex % 2;
    }else {
        index = pageIndex;
    }
    if (self.headerScrollViewClicked) {
        self.headerScrollViewClicked(index);
    }
}


/**
 *  视频菜单选项操作
 *
 *  @param sender 八个button事件
 */
- (IBAction)userClickAction:(id)sender {
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

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollBackImg.frame = mediaCycleScroll.frame;
}
@end
