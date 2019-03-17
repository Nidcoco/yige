//
//  YLLSelectPayView.m
//  yulala
//
//  Created by Eric on 2018/10/29.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "YLLSelectPayView.h"
#import "UIColor+FGGradient.h"

@interface YLLSelectPayView ()

@property (nonatomic, assign) NSInteger payWay;  ///< <#name#>
@property (nonatomic, strong) UIButton *payBtn;  ///< 支付按钮
@property (nonatomic, strong) JWPayDetailView *payView;  ///< <#Description#>
@end


@implementation YLLSelectPayView

@synthesize cancelBtn = _cancelBtn;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    JWPayDetailView *payDetailView = [[JWPayDetailView alloc] initWithLeftImage:@[@"ic_chat",@"ic_pay_treasure"] titles:@[@"微信支付",@"支付宝支付"] rightNorImage:@"ic_circle_gray_no_choose" rightSelImage:@"ic_circle_yellow_selected"];
    WeakSelf
    payDetailView.callBackPayType = ^(NSInteger tag) {
        StrongSelf
        self.payWay = tag;
    };
    [self.wrapView addSubview:payDetailView];
    [payDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
    }];
    [payDetailView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(15), 0, 0)];
    self.payView = payDetailView;
    
    [self.wrapView addSubview:self.payBtn];
    [self.payBtn fg_cornerRadius:AdaptedWidth(48)/2 borderWidth:0 borderColor:0];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(AdaptedWidth(313));
        make.height.offset(AdaptedWidth(48));
        make.top.equalTo(payDetailView.mas_bottom).offset(AdaptedWidth(33));
    }];
    
    
    [self.wrapView addSubview:self.cancelBtn];
    [self.cancelBtn fg_cornerRadius:AdaptedWidth(48)/2 borderWidth:kOnePixel borderColor:0xD4782A];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(AdaptedWidth(313));
        make.height.offset(AdaptedWidth(48));
        make.top.equalTo(self.payBtn.mas_bottom).offset(AdaptedWidth(10));
        make.bottom.offset(AdaptedWidth(-22));
    }];
 
    
    
    [self.payBtn jk_addActionHandler:^(NSInteger tag) {
        StrongSelf
        if (self.payAction) {
            self.payAction(self.payWay);
        }
        
        [self dismiss];
    }];
}

- (UIButton *)payBtn
{
    if (!_payBtn) {
        _payBtn = [UIButton fg_title:@"支付" fontSize:16 titleColorHex:0x000000];
        _payBtn.backgroundColor = [UIColor fg_gradientFromColor:UIColorFromHex(0xE6A830) toColor:UIColorFromHex(0xFAC832) withWidth:AdaptedWidth(313)];
        
    }
    return _payBtn;
}


- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColorFromHex(0xD4782A) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = AdaptedFontSize(16);
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
