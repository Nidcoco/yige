//
//  YLLOrderLIstModel.m
//  yulala
//
//  Created by Minimac on 2018/11/22.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "YLLOrderLIstModel.h"

@implementation YLLOrderLIstModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"items":[YLLShopCartItemModel class]};
}
@end
