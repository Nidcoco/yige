//
//  YLLOrderLIstModel.h
//  yulala
//
//  Created by Minimac on 2018/11/22.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"
#import "YLLShopCartItemModel.h"
#import "YLLShopModel.h"
#import "YSAddressModel.h"

/**
 订单列表 model
 */
@interface YLLOrderLIstModel : FGBaseModel

@property (nonatomic, copy) NSString *no;  ///< <#name#>
@property (nonatomic, copy) NSNumber *user_id;  ///< <#name#>
@property (nonatomic, copy) NSNumber *shop_id;  ///< <#name#>
@property (nonatomic, copy) NSString *status_desc;  ///< <#name#>
@property (nonatomic, copy) NSNumber *ship_fee;  ///< <#name#>
@property (nonatomic, strong) YSAddressModel *address;  ///< <#Description#>
@property (nonatomic, copy) NSArray <YLLShopCartItemModel *>*items;  ///< <#name#>
@property (nonatomic, strong) YLLShopModel *shop;  ///< <#Description#>
@property (nonatomic, copy) NSString *created_at;  ///< <#name#>
@property (nonatomic, copy) NSString *updated_at;  ///< <#name#>

//店铺订单使用
@property (nonatomic, strong) NSNumber *total_amount;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *coupon_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *status;  ///< <#Description#>

@property (nonatomic, copy) NSString *remark;  ///< <#Description#>
@property (nonatomic, copy) NSString *paid_at;  ///< <#Description#>
@property (nonatomic, copy) NSString *payment_method;  ///< <#Description#>
@property (nonatomic, copy) NSString *payment_no;  ///< <#Description#>
@property (nonatomic, copy) NSString *refund_status;  ///< <#Description#>
@property (nonatomic, copy) NSString *refund_no;  ///< <#Description#>
@property (nonatomic, copy) NSString *ship_status;  ///< <#Description#>
@property (nonatomic, copy) NSString *ship_status_desc;  ///< <#Description#>

@property (nonatomic, assign) BOOL closed;  ///< <#Description#>
@property (nonatomic, assign) BOOL reviewed;  ///< <#Description#>


@end
