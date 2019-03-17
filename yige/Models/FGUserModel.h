//
//  FGUserModel.h
//  hangyeshejiao
//
//  Created by Eric on 2018/3/28.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"

/**
 社交用户信息
 */
@interface FGUserModel : FGBaseModel

@property (nonatomic, copy) NSString *avatar;  ///< 头像
@property (nonatomic, copy) NSString *birthday;  ///< 生日
@property (nonatomic, copy) NSString *created_at;  ///< 创建时间
@property (nonatomic, copy) NSString *email;  ///< 邮箱
@property (nonatomic, copy) NSString *introduction;  ///< 简介
@property (nonatomic, copy) NSString *phone;  ///< 手机号
@property (nonatomic, copy) NSString *name;  ///< 昵称
@property (nonatomic, copy) NSString *bound_phone;  ///<
@property (nonatomic, copy) NSString *updated_at;  ///<  更新时间

@end
