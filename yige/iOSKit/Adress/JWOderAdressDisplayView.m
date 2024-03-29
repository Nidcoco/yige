//
//  JWOderAdressDisplayView.m
//  YaYouShangCheng
//
//  Created by qiuxiaofeng on 2018/1/9.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "JWOderAdressDisplayView.h"
#import "YSAddressModel.h"
@interface JWOderAdressDisplayView()
@property (nonatomic,strong)UIView *adressView;///<<#name#>
@property (nonatomic, strong)UILabel *nameLabel;///<<#name#>
@property (nonatomic, strong)UILabel *telLabel;///<<#name#>
@property (nonatomic, strong)UILabel *adressLabel;///<<#name#>
@property (nonatomic, strong)UIImageView *emptyImageV;///<name
@property (nonatomic, strong)UILabel *emptyLabel;///<<#name#>
@property (nonatomic, strong) UIImageView *arrowIV;  ///< 右箭头
@end
@implementation JWOderAdressDisplayView

- (void)setupViews{
    self.backgroundColor = [UIColor whiteColor];
 
}

- (void)configWithModel:(id)model{
    if (!model) {
        [self.adressView removeFromSuperview];
        self.adressView = nil;
        
        [self addSubview:self.emptyImageV];
        [self addSubview:self.emptyLabel];
        [self.emptyImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(AdaptedWidth(8));
        }];
        [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(self.emptyImageV.mas_bottom).offset(AdaptedWidth(8));
            make.bottom.offset(AdaptedWidth(-10));
        }];
        
        return;
    }
    
    [self.emptyLabel removeFromSuperview];
    self.emptyLabel = nil;
    [self.emptyImageV removeFromSuperview];
    self.emptyImageV = nil;
    
    [self addSubview:self.adressView];
    [self.adressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    if ([model isKindOfClass:[YSAddressModel class]]) {
        YSAddressModel *adress = model;
        self.nameLabel.text = [NSString stringWithFormat:@"收货人:%@",adress.contact_name];
        self.telLabel.text = adress.contact_phone;

        self.adressLabel.text = NSStringFormat(@"收货地址：%@%@%@ %@",adress.province,adress.city,adress.district,adress.address);
    }
//    //订单详情中使用
//    else if ([model isKindOfClass:[YSOrderCommonModel class]]){
//        YSOrderCommonModel *adress = model;
//        self.arrowIV.hidden = YES;
//        self.nameLabel.text = [NSString stringWithFormat:@"收货人:%@",adress.reciver_name];
//        self.telLabel.text = adress.reciver_mobile;
//        NSString *region = [adress.reciver_region stringByReplacingOccurrencesOfString:@"/" withString:@""];
//        self.adressLabel.text = NSStringFormat(@"收货地址：%@%@",region,adress.reciver_address);
//    }
    
    
}

- (UIImageView *)emptyImageV{
    if (!_emptyImageV) {
        _emptyImageV = [UIImageView fg_imageString:@"ic_add_address"];
    }
    return _emptyImageV;
}

- (UILabel *)emptyLabel{
    if (!_emptyLabel) {
        _emptyLabel = [UILabel fg_text:@"请设置收货地址" fontSize:15 colorHex:0x333333];
    }
    return _emptyLabel;
}

- (UIView *)adressView{
    if (!_adressView) {
        _adressView = [UIView new];
        
        UIImageView *leftImageV = [UIImageView fg_imageString:@"ic_address_gray"];
        [_adressView addSubview:leftImageV];
        [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(AdaptedWidth(14));
        }];
        
        UIImageView *rightImageV = [UIImageView fg_imageString:@"ic_arrow_right_dark_gray"];
        self.arrowIV = rightImageV;
        [_adressView addSubview:rightImageV];
        [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(AdaptedWidth(-13));
            make.centerY.offset(0);
        }];
        
        UIImageView *bottomImageV = [UIImageView fg_imageString:@"bg_shipping_address"];
        [_adressView addSubview:bottomImageV];
        [bottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.mas_equalTo(AdaptedWidth(4));
        }];
        
        UILabel *nameLabel = [UILabel fg_text:nil fontSize:15 colorHex:0x333333];
        [_adressView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *telLabel = [UILabel fg_text:nil fontSize:15 colorHex:0x333333];
        [_adressView addSubview:telLabel];
        self.telLabel = telLabel;
        
        
        UILabel *adressLabel = [UILabel fg_text:nil fontSize:15 colorHex:0x333333];
        adressLabel.numberOfLines = 0;
        [_adressView addSubview:adressLabel];
        self.adressLabel = adressLabel;
        
        //约束
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(AdaptedWidth(43));
            make.top.offset(AdaptedWidth(20));
        }];
        
        [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(AdaptedWidth(-47));
            make.top.offset(AdaptedWidth(23));
        }];
        
        [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(AdaptedWidth(15));
            make.left.equalTo(self.nameLabel);
            make.right.equalTo(self.telLabel);
            make.bottom.offset(AdaptedWidth(-23));
        }];
        _adressView.clipsToBounds = YES;
        
    }
    
    return _adressView;
}





@end
