//
//  YLLCollectModel.h
//  yulala
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"
#import "YLLGoodsModel.h"
#import "YLLShopModel.h"
@interface YLLCollectModel : FGBaseModel

@property (nonatomic, strong) NSNumber *user_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *target_id;  ///< <#Description#>

@property (nonatomic, copy) NSString *target_type;  ///< <#Description#>
@property (nonatomic, copy) NSString *created_at;  ///< <#Description#>
@property (nonatomic, copy) NSString *updated_at;  ///< <#Description#>

@property (nonatomic, strong) YLLGoodsModel *product;  ///< <#Description#>
@property (nonatomic, strong) FGUserModel *user;  ///< <#Description#>
@property (nonatomic, strong) YLLShopModel *shop;  ///< <#Description#>
@property (nonatomic, assign) BOOL select;  ///< <#name#>
@end
