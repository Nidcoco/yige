//
//  YLLShopCategoriesModel.h
//  yulala
//
//  Created by Eric on 2018/11/19.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"
#import "YLLGoodsModel.h"

/**
 商铺商品分类
 */
@interface YLLShopCategoriesModel : FGBaseModel

@property (nonatomic, strong) NSNumber *pid;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *shop_id;  ///< <#Description#>

@property (nonatomic, copy) NSString *name;  ///< <#Description#>

@property (nonatomic, strong) NSArray<YLLGoodsModel*> *products;  ///< <#Description#>

@property (nonatomic, assign, getter=isSelectStatus) BOOL selectStatus;  ///< 是否选中状态 (我的分类中需要使用到此属性)

@end
