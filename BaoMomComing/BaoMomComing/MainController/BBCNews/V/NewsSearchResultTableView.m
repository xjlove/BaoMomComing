//
//  NewsSearchResultTableView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/12/5.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "NewsSearchResultTableView.h"

@interface NewsSearchResultTableView ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArrM;
}

@end

@implementation NewsSearchResultTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self == [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        dataArrM = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setNewsSearchResultTableViewWithDict:(NSDictionary*)dict{
    NSArray *arr = [dict objectForKey:@"tngou"];
    for (NSDictionary *tempDict in arr) {
        NewsModel *newsModel = [[NewsModel alloc] initWithDictionary:tempDict];
        [dataArrM addObject:newsModel];
    }
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NewsModel *newsModel = dataArrM[indexPath.row];
    
    cell.textLabel.text = newsModel.title;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = newsModel.time;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = dataArrM[indexPath.row];
    CGSize size1 = [model.title boundingRectWithSize:CGSizeMake(self.width-35, 1000) options:                  NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil].size;
    CGSize size2 = [model.time boundingRectWithSize:CGSizeMake(self.width-35, 1000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    return size1.height+size2.height+ 10;
}

@end
