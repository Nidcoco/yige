//
//  FGBannerModel.h
//  yulala
//
//  Created by Eric on 2018/11/14.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGBaseModel.h"

@interface FGBannerModel : FGBaseModel

@property (nonatomic, strong) NSNumber *position_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *status;  ///< <#Description#>

@property (nonatomic, copy) NSString *title;  ///< <#Description#>
@property (nonatomic, copy) NSString *cover;  ///< <#Description#>
@property (nonatomic, copy) NSString *url;  ///< <#Description#>
@property (nonatomic, copy) NSString *content;  ///< <#Description#>
@property (nonatomic, copy) NSString *start_time;  ///< <#Description#>
@property (nonatomic, copy) NSString *end_time;  ///< <#Description#>

@property (nonatomic, strong) NSDictionary *extra;  ///< <#Description#>

@end
