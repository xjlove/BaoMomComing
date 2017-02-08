//
//  XJBMCShopViewController.m
//  BaoMomComing
//
//  Created by xj_love on 16/7/29.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJBMCShopViewController.h"

@interface XJBMCShopViewController ()

@end

@implementation XJBMCShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-HEADER-FOOT)];
    img.image = [UIImage imageNamed:@"noSome"];
    [self.view addSubview:img];
    /*
     @"http://gouwu.doukantv.com/c/home/?bundle=com.doukan.boluogouwu&category=1&cli=iphone&ver=1.3"
     http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=&q=&pageindex=1&order=new&channel=1&ver=1.3&bundle=com.doukan.boluogouwu&pid=
     @[@"http://gouwu.doukantv.com/c/home/?bundle=com.doukan.boluogouwu&category=1&cli=iphone&ver=1.3",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=&q=&pageindex=1&order=new&channel=348&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=6&q=&pageindex=1&order=new&channel=&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=9&q=&pageindex=1&order=new&channel=&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=&q=&pageindex=1&order=new&channel=895&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=14&q=&pageindex=1&order=new&channel=&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=7&q=&pageindex=1&order=new&channel=&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=8&q=&pageindex=1&order=new&channel=&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=11&q=&pageindex=1&order=new&channel=&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=12&q=&pageindex=1&order=new&channel=&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     @"http://gouwu.doukantv.com/c/list/?pagesize=20&cli=iphone&category=15&q=&pageindex=1&order=new&channel=&ver=1.3&bundle=com.doukan.boluogouwu&pid=",
     ];
     }

     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
