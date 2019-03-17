//
//  YLLGoodsModel.h
//  yulala
//
//  Created by Eric on 2018/11/7.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"

@class YLLShopModel;

@interface YLLValueModel : FGBaseModel

@property (nonatomic, copy) NSString *value;  ///< <#Description#>
@property (nonatomic, assign) BOOL disEnable;  ///< YES不可点击

@end

@interface YLLGoodsAttributesModel : FGBaseModel

@property (nonatomic, copy) NSString *name;  ///< <#Description#>
@property (nonatomic, copy) NSString *value;  ///< <#Description#>
@property (nonatomic, strong) NSArray<YLLValueModel*> *items;  ///< <#Description#>
@property (nonatomic, assign) NSInteger selectIndex;  ///< 当前选中items（添加属性）


@end


/**
 商品 model
 */
@interface YLLGoodsModel : FGBaseModel

@property (nonatomic, strong) NSNumber *shop_category_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *category_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *shop_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *rating;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *sold_count;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *review_count;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *price;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *original_price;  ///< <#Description#>

@property (nonatomic, copy) NSString *category_name;  ///< <#Description#>
@property (nonatomic, copy) NSString *shop_category_name;  ///< <#Description#>
@property (nonatomic, copy) NSString *title;  ///< <#Description#>
@property (nonatomic, copy) NSString *descriptionString;  ///< <#Description#>
@property (nonatomic, copy) NSString *summary;  ///< <#Description#>
@property (nonatomic, copy) NSString *image;  ///< <#Description#>
@property (nonatomic, copy) NSString *created_at;  ///< <#Description#>
@property (nonatomic, copy) NSString *updated_at;  ///< <#Description#>
@property (nonatomic, copy) NSNumber *ship_fee;  ///< 运费
@property (nonatomic, assign) BOOL favored;  ///< <#Description#>
@property (nonatomic, assign) BOOL on_sale;  ///< <#Description#>

@property (nonatomic, strong) NSArray<NSString*> *images;  ///< <#Description#>
@property (nonatomic, strong) NSArray<YLLGoodsAttributesModel*> *sku_attributes;  ///< <#Description#>

@property (nonatomic, strong) YLLShopModel *shop;  ///< 店铺

//库存中使用
@property (nonatomic, strong) NSNumber *product_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *stock;  ///< <#Description#>
@property (nonatomic, strong) NSDictionary *skus;  ///< <#Description#>
@property (nonatomic, strong) NSArray<YLLGoodsAttributesModel*> *attributes;  ///< <#Description#>

//新增属性
@property (nonatomic, strong) NSArray<YLLGoodsModel*> *skuArray;///<
@property (nonatomic, strong) NSMutableSet *skuSet;  ///< 商品每组合的规格拼接字符串集合

@property (nonatomic, assign, getter=isSelectStatus) BOOL selectStatus;  ///< 是否选中状态 (批量管理中需要使用到此属性)

@property (nonatomic, copy, readonly) NSString *videoUrl;  ///< 获取到视频连接

@end
