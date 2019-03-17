//
//  YSShopCartNumberView.h
//  YaYouShangCheng
//
//  Created by 陈经纬 on 2018/2/6.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGBaseView.h"

@interface FGShopCartNumberView : FGBaseView

/// 减少图标（默认无）
@property (nonatomic, strong) UIImage *reduceImageNormal;
/// 减少高亮图标（默认无）
@property (nonatomic, strong) UIImage *reduceImageHighlight;
/// 减少不可点击图标（默认无）
@property (nonatomic, strong) UIImage *reduceImageDisenable;
/// 减少按钮标题（默认-）
@property (nonatomic, strong) NSString *reduceTitleNormal;
/// 减少按钮高亮标题（默认-）
@property (nonatomic, strong) NSString *reduceTitleHighlight;
/// 减少按钮字体大小（默认12）
@property (nonatomic, strong) UIFont *reduceFont;
/// 减少按钮字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *reduceTitleColorNormal;
/// 减少按钮字体高亮颜色（默认黑色）
@property (nonatomic, strong) UIColor *reduceTitleColorHighlight;


/// 增加图标（默认无）
@property (nonatomic, strong) UIImage *addImageNormal;
/// 增加高亮图标（默认无）
@property (nonatomic, strong) UIImage *addImageHighlight;
/// 增加不可点击图标
@property (nonatomic, strong) UIImage *addImageDisenable;
/// 增加按钮标题（默认+）
@property (nonatomic, strong) NSString *addTitleNormal;
/// 增加按钮高亮标题（默认+）
@property (nonatomic, strong) NSString *addTitleHighlight;
/// 增加按钮字体大小（默认12）
@property (nonatomic, strong) UIFont *addFont;
/// 增加按钮字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *addTitleColorNormal;
/// 增加按钮字体高亮颜色（默认黑色）
@property (nonatomic, strong) UIColor *addTitleColorHighlight;


/// 字体大小（默认12）
@property (nonatomic, strong) UIFont *textFont;
/// 字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *textColor;

/// 数量值（默认0）
@property (nonatomic, assign) CGFloat number;
/// 最大数量值（默认无限大）
@property (nonatomic, assign) CGFloat numberMax;
/// 最小数量值（默认0）
@property (nonatomic, assign) CGFloat numberMin;

/// 增加的倍数(默认1)
@property (nonatomic, assign) CGFloat multiple;


/// 数量回调
@property (nonatomic, copy) void (^numberEdit)(CGFloat number);

@property (nonatomic, assign) BOOL canEditing;  ///< 是否可编辑,默认No

@end
