//
//  YLLAttestModel.h
//  yulala
//
//  Created by Eric on 2018/11/14.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"

@interface YLLAttestItemModel : FGBaseModel

@property (nonatomic, strong) NSNumber *status;  ///< 0 未认证 1 待审核 2 认证中 3 成功 4 失败

@property (nonatomic, copy) NSString *status_desc;  ///< <#Description#>
@property (nonatomic, copy) NSString *name;  ///< <#Description#>
@property (nonatomic, copy) NSString *number;  ///< <#Description#>
@property (nonatomic, copy) NSString *front;  ///< <#Description#>
@property (nonatomic, copy) NSString *back;  ///< <#Description#>
@property (nonatomic, copy) NSString *images;  ///< <#Description#>
@property (nonatomic, copy) NSString *created_at;  ///< <#Description#>

@end

/**
 认证model
 */
@interface YLLAttestModel : FGBaseModel

@property (nonatomic, strong) YLLAttestItemModel *identity;  ///< 个人

@property (nonatomic, strong) YLLAttestItemModel *company;  ///< 企业

@property (nonatomic, strong) YLLAttestItemModel *qualification;  ///< 资质

@property (nonatomic, strong) YLLAttestItemModel *field;  ///< 地方

@end
