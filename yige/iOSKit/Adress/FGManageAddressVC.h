//
//  FGManageAddressVC.h
//  YaYouShangCheng
//
//  Created by qiuxiaofeng on 2018/1/16.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGBaseRefreshTableViewController.h"

@interface FGManageAddressVC : FGBaseRefreshTableViewController
@property (nonatomic,copy) void ((^didSelect)(id item));///<<#name#>
@end
