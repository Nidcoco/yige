//
//  FGMessageModel.h
//  quanminyuanchuang
//
//  Created by Eric on 2018/9/7.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"

@interface FGMessageModel : FGBaseModel

@property (nonatomic, strong) NSNumber *receiverUserId;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *senderUserId;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *createTime;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *updateTime;  ///< <#Description#>

@property (nonatomic, copy) NSString *text;  ///<  内容 ,
@property (nonatomic, copy) NSString *title;  ///< 标题
@property (nonatomic, copy) NSString *metaType;  ///< 目标数据类型
@property (nonatomic, copy) NSString *type;  ///< 类型
@property (nonatomic, copy) NSString *meta;  ///< meta 是一个 Json 化的 对象

@property (nonatomic, assign) BOOL pushFlag;  ///< 是否推送：false否 true是

@end
