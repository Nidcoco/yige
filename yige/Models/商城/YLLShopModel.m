//
//  YLLShopModel.m
//  yulala
//
//  Created by Eric on 2018/11/7.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "YLLShopModel.h"

@implementation YLLShopModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"products":[YLLGoodsModel class]};
}
@end
