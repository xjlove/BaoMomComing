#import "XJBMCNewsViewController.h"

@interface XJBMCNewsViewController ()<ZJScrollPageViewDelegate,PYSearchViewControllerDelegate>

@property (nonatomic, strong)NSArray<NSString*> *topTitlesArr;
@property (nonatomic, strong)ZJSegmentStyle *topSegmentStyle;
@property (nonatomic, strong)ZJScrollPageView *topScrollPageView;
@property (nonatomic, strong)PYSearchViewController *searchViewController;
@property (nonatomic, strong)NewsSearchResultTableView *newsSearchResultView;

@end

@implementation XJBMCNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //http://www.tngou.net/doc/#healthy
    [self loadAllView];
}

#pragma mark - **************************** 加载所有视图 *************************************
- (void)loadAllView{
    [self.view addSubview:self.topScrollPageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 25, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"NewsSearch"] forState:UIControlStateNormal];
    [btn addTarget: self action: @selector(gotoSearchVC) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)gotoSearchVC{
    //跳转到搜索控制器
    XJRootNavigationController *nav = [[XJRootNavigationController alloc] initWithRootViewController:self.searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

#pragma mark - **************************** PYSearchViewControllerDelegate 代理方法 *****************************
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (!searchText.length) { // 与搜索条件再搜索
        [searchViewController.searchResultTableView removeFromSuperview];
        [self.newsSearchResultView removeFromSuperview];
    }
}

- (void)didClickCancel:(PYSearchViewController *)searchViewController{
    searchViewController.searchBar.text = nil;
    [searchViewController.searchResultTableView removeFromSuperview];
    [self.newsSearchResultView removeFromSuperview];
    [MANAGER_SHOW dismiss];
}

#pragma mark - **************************** ZJScrollPageViewDelegate 代理方法 *************************************
- (NSInteger)numberOfChildViewControllers {
    return self.topTitlesArr.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    switch (index) {
        case 0:
        {
            if (!childVc) {
                childVc = [[BMCNews_HeadLineVC alloc] init];
            }
        }
            break;
        case 1:
        {
            if (!childVc) {
                childVc = [[BMCNews_EnterpriseVC alloc] init];
            }
        }
            break;
        case 2:
        {
            if (!childVc) {
                childVc = [[BMCNews_MedicalVC alloc] init];
            }
        }
            break;
        case 3:
        {
            if (!childVc) {
                childVc = [[BMCNews_LiveTapsVC alloc] init];
            }
        }
            break;
        case 4:
        {
            if (!childVc) {
                childVc = [[BMCNews_DrugVC alloc] init];
            }
        }
            break;
        case 5:
        {
            if (!childVc) {
                childVc = [[BMCNews_FoodVC alloc] init];
            }
        }
            break;
        case 6:
        {
            if (!childVc) {
                childVc = [[BMCNews_SocietyHotVC alloc] init];
            }
        }
            break;
        case 7:
        {
            if (!childVc) {
                childVc = [[BMCNews_DiseaseVC alloc] init];
            }
        }
            break;
            
        default:
            break;
    }
    
    return childVc;
}

#pragma mark - **************************** 懒加载 *************************************
- (NSArray<NSString *> *)topTitlesArr{
    if (_topTitlesArr == nil) {
        _topTitlesArr = [NSArray arrayWithObjects:@"头条",@"企业要闻",@"医疗新闻",@"生活贴士",@"药品新闻",@"食品新闻",@"社会热点",@"疾病快讯", nil];
    }
    return _topTitlesArr;
}

- (ZJSegmentStyle *)topSegmentStyle{
    if (_topSegmentStyle == nil) {
        _topSegmentStyle = [[ZJSegmentStyle alloc] init];
        // 缩放标题
        _topSegmentStyle.scaleTitle = YES;
        // 颜色渐变
        _topSegmentStyle.gradualChangeTitleColor = YES;
        // 选中颜色
        _topSegmentStyle.selectedTitleColor = ALLBACK_COLOR;
    }
    return _topSegmentStyle;
}

- (ZJScrollPageView *)topScrollPageView{
    if (_topScrollPageView == nil) {
        _topScrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0,HEADER, self.view.bounds.size.width, self.view.bounds.size.height - HEADER-FOOT) segmentStyle:self.topSegmentStyle titles:self.topTitlesArr parentViewController:self delegate:self];
    }
    return _topScrollPageView;
}

- (PYSearchViewController *)searchViewController{
    if (_searchViewController == nil) {
        // 1.创建热门搜索
        NSArray *hotSeaches = @[@"宝宝", @"健康", @"饮食", @"高血压", @"老年活动", @"增强体力", @"健康成长", @"医药新闻", @"筋骨不老", @"天天向上", @"预防老年痴呆", @"宝妈来了", @"年轻人的生活", @"血糖"];
        // 2. 创建控制器
        _searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入关键词..." didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            // 开始搜索执行以下代码
            
            [MANAGER_SHOW showWithInfo:loadingMessage inView:searchViewController.view];
            [MANAGER_HTTP doGetJson:[NSString stringWithFormat:BMC_News_Search_newsUrl,Host_news,searchText] withCompletionBlock:^(id obj) {
                [MANAGER_SHOW dismiss];
                
                NSDictionary *dict = [MANAGER_PARSE parseJsonToDict:obj];
                
                [self.newsSearchResultView setNewsSearchResultTableViewWithDict:dict];
                
                [_searchViewController.view addSubview:self.newsSearchResultView];
                
            } withFailBlock:^(NSError *error) {
                
            }];
        }];
        _searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; // 热门搜索风格
        _searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault; // 搜索历史风格
        _searchViewController.delegate = self;//设置代理
        _searchViewController.searchResultShowMode = PYSearchResultShowModeEmbed;//结果跳转样式
        _searchViewController.searchSuggestionHidden = YES;//是否开启联想功能
    }
    return _searchViewController;
}

- (NewsSearchResultTableView *)newsSearchResultView{
    if (_newsSearchResultView == nil) {
        _newsSearchResultView = [[NewsSearchResultTableView alloc] initWithFrame:CGRectMake(0, HEADER, self.view.width, self.view.height-HEADER) style:UITableViewStylePlain];
    }
    return _newsSearchResultView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
