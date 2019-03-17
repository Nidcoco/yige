//
//  YLLCommentModel.h
//  yulala
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"

/**
 商品评价 model
 */
@interface YLLCommentModel : FGBaseModel

@property (nonatomic, strong) NSNumber *user_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *product_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *sku_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *grade;  ///< <#Description#>

@property (nonatomic, copy) NSString *content;  ///< <#Description#>
@property (nonatomic, copy) NSString *created_at;  ///< <#Description#>
@property (nonatomic, copy) NSString *updated_at;  ///< <#Description#>

@property (nonatomic, assign) BOOL is_anonymous;  ///< <#Description#>

@property (nonatomic, strong) NSArray<NSString*> *images;  ///< <#Description#>
@property (nonatomic, strong) FGUserModel *user;  ///< <#Description#>


@end
