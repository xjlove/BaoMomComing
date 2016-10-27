//
//  XJRootNavigationController.m
//  BaoMomComing
//
//  Created by xj_love on 2016/10/26.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJRootNavigationController.h"

@implementation XJRootNavigationController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    // 私有接口实现右滑返回
    //    [self rightSwipe];
    //动态更改导航背景/样式
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor colorWithRed:242.0/255.0 green:132.0/255.0 blue:166/255.0 alpha:1.0]];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName:
                                      [UIColor whiteColor],
                                  NSFontAttributeName:
                                      [UIFont boldSystemFontOfSize:20]}];
    //导航条中按钮样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName
                                   :[UIColor whiteColor],
                                   NSFontAttributeName
                                   :[UIFont boldSystemFontOfSize:20]}
                        forState:UIControlStateNormal];
}

//更改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}


- (void)rightSwipe {
    // 获取系统原始手势的view,并把原始手势关闭
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    popRecognizer.delaysTouchesBegan = YES;
    [gestureView addGestureRecognizer:popRecognizer];
    
    /**
     *  获取系统手势的target数组
     */
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    /**
     *  通过前面的打印，我们从控制台获取出来它的方法签名。
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Can't add self as subview
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.isAnimating) {
        return;
    }
    
    _isAnimating = animated;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (self.isAnimating) {
        return nil;
    }
    
    _isAnimating = animated;
    return [super popViewControllerAnimated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.isAnimating = NO;
}

@end
