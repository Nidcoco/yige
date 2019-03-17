//
//  PopTableListView.h
//  PopView
//
//  Created by 李林 on 2018/2/28.
//  Copyright © 2018年 李林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopView.h"
@interface PopTableListView : UIView

/**
 初始化方法

 @param titles 文字
 @param imgNames 图片 没有就设置nil
 @return <#return value description#>
 */
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles imgNames:(NSArray <NSString *>*)imgNames;

/**
 更新内容
 */
- (void)reloadDataWithTitles:(NSArray *)titles imgNames:(NSArray <NSString *>*)imgNames;

/**
 消息 红点是否显示 (默认是不显示)
 */
- (void)messageRedPoint:(BOOL)show;

@property (nonatomic, strong) NSIndexPath *index;  ///< 
@property (nonatomic,copy)void ((^didselectItem)(NSString *item,NSIndexPath *index));
@property (nonatomic, strong) UIColor  *normalColor;  ///< Descriptionr
@property (nonatomic, strong) UIColor  *selectColor;  ///< <#Description#>

@end
