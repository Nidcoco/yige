//
//  YLLShopCategoriesModel.m
//  yulala
//
//  Created by Eric on 2018/11/19.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "YLLShopCategoriesModel.h"

@implementation YLLShopCategoriesModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"products":[YLLGoodsModel class]};
}

@end
