//
//  YLLShopCartItemModel.h
//  yulala
//
//  Created by Minimac on 2018/11/19.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"

@interface YLLShopCartItemModel : FGBaseModel

@property (nonatomic, copy)NSNumber  *product_id;  ///< name
@property (nonatomic, copy)NSNumber  *product_sku_id;  ///< name
@property (nonatomic, copy)NSNumber  *shop_id;  ///< name
@property (nonatomic, copy) NSNumber *amount;  ///< <#name#>
@property (nonatomic, strong) NSNumber *order_id;  ///< <#Description#>
@property (nonatomic, copy) NSString *price;  ///< <#Description#>

@property (nonatomic, strong) YLLGoodsModel *product_sku;  ///< <#Description#>
@property (nonatomic, strong) YLLGoodsModel *product;  ///< <#Description#>
@property (nonatomic, assign) BOOL selected;  ///< 是否选中（新增属性）
@end
