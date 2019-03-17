//
//  YLLGoodsCategoriesModel.m
//  yulala
//
//  Created by Eric on 2018/11/6.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "YLLGoodsCategoriesModel.h"

@implementation YLLGoodsCategoriesModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"ID":@"id",@"descriptionString":@"description"};
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"subs":[YLLGoodsCategoriesModel class]};
}

@end
