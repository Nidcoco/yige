//
//  YLLSelectPayView.h
//  yulala
//
//  Created by Eric on 2018/10/29.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseView.h"
#import "JWPayDetailView.h"
#import "FGSheetPopControl.h"

/**
 选择支付方式
 */
@interface YLLSelectPayView : FGSheetPopControl
@property (nonatomic, copy) void ((^payAction)(NSInteger payWay));  ///< <#name#>



@end
