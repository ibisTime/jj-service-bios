//
//  TLPageDataHelper.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/17.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLPageDataHelper.h"

@interface TLPageDataHelper()

@property (nonatomic,strong) NSMutableArray *objs;
@property (nonatomic,assign) BOOL refreshed;


@end

@implementation TLPageDataHelper
{

    Class _className;
}

- (instancetype)init {

    if (self = [super init]) {
        
        self.start = 1;
        self.limit = 20;
        self.refreshed = NO;
        self.objs = [[NSMutableArray alloc] init];
        self.parameters = [NSMutableDictionary dictionary];
        self.isAutoDeliverCompanyCode = YES;
        
    }
    return self;
}

- (void)refresh:(void(^)(NSMutableArray *objs,BOOL stillHave))refresh failure:(void(^)(NSError *error))failure{

    self.start = 1;
    
    TLNetworking *http = [TLNetworking new];
    http.code = self.code;
    http.isAutoDeliverCompanyCode = self.isAutoDeliverCompanyCode;
    http.parameters = self.parameters;
    http.parameters[@"start"] = [NSString stringWithFormat:@"%ld",self.start];
    http.parameters[@"limit"] = [NSString stringWithFormat:@"%ld",self.limit];;
    [http postWithSuccess:^(id responseObject) {
        NSArray *newObjs = responseObject[@"data"][@"list"];
        self.objs = [_className mj_objectArrayWithKeyValuesArray:newObjs];
        
        //防止刚进入没刷新，就上拉
        self.refreshed = YES;
        if (self.tableView) {
            [self.tableView resetNoMoreData_tl];
            [self.tableView endRefreshHeader];
        }
        
        BOOL stillHave = YES;
        if ([responseObject[@"data"][@"totalPage"] isEqual:@1]) {
            //告诉外界没有更多数据
            if (refresh) {
                stillHave = NO;
                refresh(self.objs,NO);
            }
            
        } else {
            //还有数据
            self.start += 1;
            if (refresh) {
                stillHave = YES;
                refresh(self.objs,YES);
            }

        }
        
        if (!stillHave && self.tableView) {
            [self.tableView endRefreshingWithNoMoreData_tl];
        }
        
        
    } failure:^(NSError *error) {
     
        if (self.tableView) {
            [self.tableView endRefreshHeader];
        }
     
        if (failure) {
            failure(error);
        }
        
    }];


}

//pageNO = 1;
//pageSize = 20;
//start = 0;
//totalCount = 1;
//totalPage = 1;

- (void)loadMore:(void(^)(NSMutableArray *objs,BOOL stillHave))loadMore failure:(void(^)(NSError *error))failure{
    
    if (!self.refreshed) {
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.code = self.code;
    http.isAutoDeliverCompanyCode = self.isAutoDeliverCompanyCode;
    http.parameters = self.parameters;
    http.parameters[@"start"] = [NSString stringWithFormat:@"%ld",self.start];
    http.parameters[@"limit"] = [NSString stringWithFormat:@"%ld",self.limit];;
    [http postWithSuccess:^(id responseObject) {
        
        if (self.tableView) {
            
            [self.tableView endRefreshFooter];

        }

        //拼接数据
        NSArray *newObjs = responseObject[@"data"][@"list"];
        if (newObjs.count) {
            [self.objs addObjectsFromArray:[_className mj_objectArrayWithKeyValuesArray:newObjs]];
        }
        
        BOOL stillHave = YES;
        if(self.start*self.limit >= [responseObject[@"data"][@"totalCount"] integerValue]){
           //告诉外界没有数据
            if (loadMore) {
                stillHave = NO;
                loadMore(self.objs,stillHave);
            }
            
        } else {
            
            if (loadMore) {
                stillHave = YES;
                loadMore(self.objs,stillHave);
            }
            self.start += 1;
            
        }
        
        //简便方法
        if (!stillHave && self.tableView) {
            [self.tableView endRefreshingWithNoMoreData_tl];
        }
        
    } failure:^(NSError *error) {
        
        if (self.tableView) {
            [self.tableView endRefreshHeader];
        }
        
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}

- (void)modelClass:(Class)className {

    _className = className;

}



@end
