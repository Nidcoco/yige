//
//  YLLGoodsModel.m
//  yulala
//
//  Created by Eric on 2018/11/7.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "YLLGoodsModel.h"

@implementation YLLValueModel

@end

@implementation YLLGoodsAttributesModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"items":[YLLValueModel class]};
}

@end



@implementation YLLGoodsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"sku_attributes":[YLLGoodsAttributesModel class],
             @"attributes":[YLLGoodsAttributesModel class]
             };
}

- (NSArray<YLLGoodsModel *> *)skuArray{
    NSArray *arr = [NSArray modelArrayWithClass:[YLLGoodsModel class] json:_skus[@"data"]];
    return arr;
}

- (NSString *)videoUrl
{
    __block NSString *url;
    [self.images enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasSuffix:@"mp4"]) {
            url = obj;
        }
    }];
    return url;
}


@end
