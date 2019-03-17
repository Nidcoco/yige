//
//  DDAlertView.h
//  dingdingxuefu
//
//  Created by Eric on 2018/7/9.
//

#import <UIKit/UIKit.h>

@interface DDAlertView : UIControl

- (void)show;
@property (nonatomic, copy) void (^didSelected) (BOOL isCancel);
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message btnNames:(NSArray *)btnNames;

@end
