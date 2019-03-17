//
//  YLLShopCartModel.m
//  yulala
//
//  Created by Minimac on 2018/11/19.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "YLLShopCartModel.h"

@implementation YLLShopCartModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"items":[YLLShopCartItemModel class]};
}


@end
