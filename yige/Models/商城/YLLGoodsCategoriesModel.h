//
//  YLLGoodsCategoriesModel.h
//  yulala
//
//  Created by Eric on 2018/11/6.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"

/**
 商品分类
 */
@interface YLLGoodsCategoriesModel : FGBaseModel

@property (nonatomic, strong) NSNumber *pid;  ///< <#Description#>

@property (nonatomic, copy) NSString *name;  ///< <#Description#>
@property (nonatomic, copy) NSString *alias;  ///< <#Description#>
@property (nonatomic, copy) NSString *image;  ///< <#Description#>
@property (nonatomic, copy) NSString *descriptionString;  ///< <#Description#>

@property (nonatomic, strong) NSArray<YLLGoodsCategoriesModel *> *subs;  ///< <#Description#>

@end
