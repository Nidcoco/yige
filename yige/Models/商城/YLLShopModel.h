//
//  YLLShopModel.h
//  yulala
//
//  Created by Eric on 2018/11/7.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"
#import "YLLGoodsModel.h"

/**
 店铺 model
 */
@interface YLLShopModel : FGBaseModel

@property (nonatomic, strong) NSNumber *user_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *lat;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *lng;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *category_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *view_count;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *favorite_count;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *product_count;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *rating;  ///< <#Description#>

@property (nonatomic, copy) NSString *name;  ///< <#Description#>
@property (nonatomic, copy) NSString *logo;  ///< <#Description#>
@property (nonatomic, copy) NSString *introduce;  ///< <#Description#>
@property (nonatomic, copy) NSString *business_scope;  ///< <#Description#>
@property (nonatomic, copy) NSString *address;  ///< <#Description#>
@property (nonatomic, copy) NSString *contact;  ///< 联系人
@property (nonatomic, copy) NSString *telphone;  ///< 电话
@property (nonatomic, copy) NSString *tags;  ///< <#Description#>
@property (nonatomic, copy) NSString *created_at;  ///< <#Description#>
@property (nonatomic, copy) NSString *updated_at;  ///< <#Description#>

@property (nonatomic, strong) NSArray<NSString*> *images;  ///< <#Description#>
@property (nonatomic, strong) NSArray<YLLGoodsModel*> *products;  ///< <#Description#>

@property (nonatomic, assign) BOOL field_certified;  ///< <#Description#>
@property (nonatomic, assign) BOOL realname_certified;  ///< <#Description#>
@property (nonatomic, assign) BOOL company_certified;  ///< <#Description#>
@property (nonatomic, assign) BOOL on_sale;  ///< <#Description#>
@property (nonatomic, assign) BOOL favored;  ///< <#Description#>

@end
