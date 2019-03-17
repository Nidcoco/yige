//
//  PopTableListCell.h
//  dingdingxuefu
//
//  Created by chenjingwei on 2018/7/20.
//

#import <UIKit/UIKit.h>

@interface PopTableListCell : UITableViewCell

- (void)configeTitle:(NSString *)title image:(NSString *)image;

@property (nonatomic, strong) UIColor *normalTextColor;  ///< <#Description#>
@property (nonatomic, strong) UIColor *selectTextColor;  ///< <#Description#>

//显示红点
- (void)showRedPoint;


@end
