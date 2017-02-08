//
// MediaEvaluateTableView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/9.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaEvaluateTableView.h"

@interface MediaEvaluateTableView ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArrM;
    NSString *lastCommentID;
    
    MediaEvaluateTableViewCell *evaluateListCell;
    MediaEvaluateHeadTableViewCell *evaluatHeadCell;
}

@end

@implementation MediaEvaluateTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor colorWithRed:(float)247/255 green:(float)247/255 blue:(float)247/255 alpha:1];
        dataArrM = [NSMutableArray array];
        lastCommentID = @"";
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if ([MANAGER_Reach isEnableNetWork]) {
                [self setMeidaID:_meidaID];
            }
        }];
    }
    return self;
}

#pragma mark - **************************** 加载数据 *************************************
- (void)setMeidaID:(NSString *)meidaID{
    _meidaID = meidaID;
    
    if (dataArrM.count != 0) {
        EvaluateModel *evaluateModel = [dataArrM lastObject];
        lastCommentID = [NSString stringWithFormat:@"%d", evaluateModel.ID];
    }
    NSString *urlStr = [NSString stringWithFormat:BMC_Media_comment_list,Host_media,meidaID,lastCommentID];
    
    [MANAGER_Data parseJsonData:urlStr FileName:@"Media_commentList.json" ShowLoadingMessage:NO JsonType:ParseJsonTypeMediaComment finishCallbackBlock:^(NSMutableArray *result) {
        [self.mj_footer endRefreshing];
        [dataArrM addObjectsFromArray:result];
        [self reloadData];
    }];
}

#pragma mark - **************************** UITableViewDelegate+UITableViewDataSource *************************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrM.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = nil;
    if (indexPath.row == 0) {
        cellID = @"MediaEvaluateHeadTableViewCell";
    }else{
        cellID = @"MediaEvaluateTableViewCell";
    }
    
    if (indexPath.row == 0) {
        [tableView registerClass:[MediaEvaluateHeadTableViewCell class] forCellReuseIdentifier:cellID];
        evaluatHeadCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        return evaluatHeadCell;
    }else{
        EvaluateModel *evaluateModel = [dataArrM objectAtIndex:indexPath.row-1];
        
        [tableView registerClass:[MediaEvaluateTableViewCell class] forCellReuseIdentifier:cellID];
        evaluateListCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        [evaluateListCell setMediaEvaluateTableViewCellWithData:evaluateModel];
        
        return evaluateListCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
            return 78;
    }
    
    EvaluateModel *evaluateModel = [dataArrM objectAtIndex:indexPath.row-1];
    
    CGSize size = [evaluateModel.comment boundingRectWithSize:CGSizeMake(self.width-80, 1000) options:
                   NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size;
    
    if (size.height > 20) {
        return size.height + 55;
    }else {
        return 75;
    }
}

@end
