//
//  YLLShopCartModel.h
//  yulala
//
//  Created by Minimac on 2018/11/19.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"
#import "YLLShopCartItemModel.h"
@interface YLLShopCartModel : FGBaseModel
@property (nonatomic, copy) NSString *name ;  ///< <#name#>
@property (nonatomic, copy) NSString *logo;  ///< name
@property (nonatomic, copy) NSNumber *ship_fee;  ///< <#name#>
@property (nonatomic, copy) NSString *remark;  ///< <#name#>
@property (nonatomic, copy) NSArray <YLLShopCartItemModel *> *items;  ///< <#name#>


@property (nonatomic, assign) BOOL selected;  ///< 是否选中（新增属性）
@end
