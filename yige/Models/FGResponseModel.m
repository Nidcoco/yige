//
//  FGResponseModel.m
//  jingpai
//
//  Created by Eric on 2018/6/21.
//  Copyright © 2018年 figo. All rights reserved.
//

#import "FGResponseModel.h"

@implementation FGResponseModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"code":@"status_code",@"msg":@"message"};
}

- (NSDictionary *)dataDict
{
    if ([_data isKindOfClass:[NSDictionary class]]) {
        return _data;
    }
    return @{};
}

- (NSArray *)dataArray
{
    if ([_data isKindOfClass:[NSArray class]]) {
        return _data;
    }
    return @[];
}


@end
