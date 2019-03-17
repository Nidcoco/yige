//
//  FGLoginVC.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/5.
//

#import "FGLoginVC.h"
#import "FGCellStyleView.h"
#import <JKCategories/NSString+JKNormalRegex.h>
#import <JKCategories/NSString+JKHash.h>
#import "UIView+EdgeLine.h"

#import "WXApi.h"
#import <UMShare/UMShare.h>

#import "FGForgetPasswordVC.h"

#import "NSString+FGNormalRegex.h"

@interface FGLoginVC ()

@property (nonatomic, strong) FGCellStyleView *mobileView; ///< 手机号
@property (nonatomic, strong) FGCellStyleView *pswView; ///< 密码
@property (nonatomic, strong) UIButton *forgetPsdBtn; ///< 忘记密码
@property (nonatomic, strong) UIButton *loginBtn; ///< 登录

//@property (nonatomic, strong) UIButton *wxLogin;  ///< 微信登陆

@property (nonatomic, strong) UILabel *misMessage;  ///< 错误提示
@property (nonatomic, strong) UIButton *secureBtn;  ///< 密码是否可见


@end

@implementation FGLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    FGTextFeidViewModel *model1 = [FGTextFeidViewModel new];
    model1.leftImgPath = @"img_login_phone_gray";
    model1.limitNum = 11;
    model1.keyboardType = UIKeyboardTypePhonePad;
    model1.contentMargin = 0;
    model1.leftImgPathMargin = 0;
    model1.placeholder = @"请输入您的手机号码";
    model1.contentFont = 15;
    self.mobileView = [[FGCellStyleView alloc] initWithModel:model1];
    [self.mobileView addBottomLineWithEdge:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:self.mobileView];
    
    FGTextFeidViewModel *model2 = [FGTextFeidViewModel new];
    model2.placeholder = @"请输入您的登录密码";
    model2.leftImgPath = @"ic_login_password_gray";
    model2.contentMargin = 0;
    model2.leftImgPathMargin = 0;
    model2.secureTextEntry = YES;
    model2.limitNum = 18;
    model2.contentFont = 15;
    self.pswView = [[FGCellStyleView alloc] initWithModel:model2];
    [self.pswView addBottomLineWithEdge:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view  addSubview:self.pswView];
    
    self.secureBtn = [UIButton fg_imageString:@"ic_eyes_close_gray" imageStringSelected:@"ic_eyes_open_gray"];
    self.secureBtn.selected = NO;
    [self.view addSubview:self.secureBtn];
    [self.secureBtn addTarget:self action:@selector(seePassword:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.misMessage = [UILabel fg_text:@"您输入的账号或密码不正确" fontSize:14 colorHex:0xEC0808];
    self.misMessage.hidden = YES;
    [self.view addSubview:self.misMessage];
    
    self.forgetPsdBtn = [UIButton fg_title:@"忘记密码?" fontSize:14 titleColorHex:0x4AB52E];
    [self.forgetPsdBtn addTarget:self action:@selector(forgetPwdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPsdBtn];
    
    self.loginBtn = [UIButton fg_title:@"登录" fontSize:15 titleColorHex:0xffffff];
    [self.loginBtn jk_setBackgroundColor:UIColorFromHex(0x4AB52E) forState:UIControlStateNormal];
    [self.loginBtn jk_setBackgroundColor:UIColorFromHex(0xA5D999) forState:UIControlStateDisabled];
    [self.loginBtn fg_cornerRadius:25 borderWidth:0 borderColor:0];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //登录按钮置灰
    RACSignal *combineSignal = [RACSignal combineLatest:@[self.mobileView.textFeild.rac_textSignal,self.pswView.textFeild.rac_textSignal] reduce:^NSNumber *_Nonnull(NSString *mobile, NSString *psw){
        return @([mobile fg_isMobileNumber] && psw.length >= 6 && psw.length <= 18);
    }];
    RAC(self.loginBtn,enabled) = combineSignal;
}

- (void)setupLayout
{
    
    [self.mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(30));
        make.left.offset(AdaptedWidth(20));
        make.right.offset(-AdaptedWidth(20));
        make.height.mas_equalTo(AdaptedWidth(52));
    }];
    
    [self.pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileView.mas_bottom);
        make.left.right.height.equalTo(self.mobileView);
    }];
    
    
    [self.secureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pswView.mas_right);
        make.height.offset(AdaptedWidth(10));
        make.width.offset(AdaptedWidth(14));
        make.top.equalTo(self.mobileView.mas_bottom).offset(AdaptedWidth(20));
    }];
    
    [self.misMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pswView.mas_bottom).offset(AdaptedWidth(18));
        make.left.equalTo(self.mobileView);
        make.height.offset(AdaptedWidth(13));
    }];
    
    [self.forgetPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mobileView);
        make.top.equalTo(self.pswView.mas_bottom).offset(AdaptedWidth(18));
        make.height.offset(AdaptedWidth(13));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetPsdBtn.mas_bottom).offset(AdaptedWidth(66));
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(AdaptedWidth(50));
        make.left.right.equalTo(self.pswView);
    }];
    
    //    //微信已安装
    //    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
    //
    //        [self.registerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.centerX.equalTo(self.bgScrollView.contentView.mas_centerX);
    //            make.top.equalTo(self.loginBtn.mas_bottom).offset(AdaptedWidth(16));
    //        }];
    //
    //        UILabel *label = [UILabel fg_text:@"——————   使用第三方登录   ——————" fontSize:14 colorHex:0x999999];
    //        [self.bgScrollView.contentView addSubview:label];
    //        [label mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.equalTo(self.registerBtn.mas_bottom).offset(AdaptedWidth(90));
    //            make.centerX.offset(0);
    //        }];
    //
    //        self.wxLogin = [UIButton fg_imageString:@"ic_circle_wechat" imageStringSelected:nil];
    //        [self.wxLogin addTarget:self action:@selector(wxLoginAction) forControlEvents:UIControlEventTouchUpInside];
    //        [self.bgScrollView.contentView addSubview:self.wxLogin];
    //        [self.wxLogin mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.centerX.offset(0);
    //            make.top.equalTo(label.mas_bottom).offset(AdaptedWidth(40));
    //            make.bottom.offset(0);
    //        }];
    //    }
}

#pragma mark - action

- (void)seePassword:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (!btn.selected) {
        self.pswView.model.secureTextEntry = YES;
    }else{
        self.pswView.model.secureTextEntry = NO;
    }
}

- (void)loginAction
{
    [self.view endEditing:YES];
    NSString *mobile = self.mobileView.model.content;
    NSString *password = self.pswView.model.content;
    
    if (![mobile fg_isMobileNumber]) {
        [self showWarningHUDWithMessage:@"输入的手机号码格式有误" completion:nil];
        return;
    }else if (password.length < 6) {
        [self showWarningHUDWithMessage:@"密码不能小于6位" completion:nil];
        return;
    }else if (password.length > 18) {
        [self showWarningHUDWithMessage:@"密码不能大于18位" completion:nil];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"username"] = mobile;
    dic[@"password"] = [password jk_md5String];
    
    [self showLoadingHUDWithMessage:@"正在登录"];
    WeakSelf
    [FGHttpManager postWithPath:@"api/authorizations" parameters:dic success:^(id responseObject) {
        StrongSelf
        
        NSString *token = objectForKey(responseObject, @"access_token");
        if (!IsEmpty(token)) {
            [FGCacheManager sharedInstance].token = token;
            
            //获取用户信息
            [FGUserHelper requestUserModelWithResult:^(BOOL success, NSString *error) {
                StrongSelf
                if (success) {
                    [self hideLoadingHUD];
                    [self.navigationController popViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSucceedNotification object:self userInfo:nil];
                }else{
                    [self showWarningHUDWithMessage:error completion:nil];
                }
                
            }];
        }
    } failure:^(NSString *error) {
        StrongSelf
        [self showWarningHUDWithMessage:error completion:nil];
    }];
}


- (void)forgetPwdAction
{
    FGForgetPasswordVC *vc = [FGForgetPasswordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


//- (void)wxLoginAction
//{
//    //获取微信授权信息
//    WeakSelf
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
//
//        StrongSelf
//        if (error) {
//
//            switch (error.code) {
//                case 2002:
//                    [self showTextHUDWithMessage:@"授权失败"];
//                    break;
//                case 2009:
//                    [self showTextHUDWithMessage:@"取消登录"];
//                    break;
//                default:
//                    [self showTextHUDWithMessage:@"服务繁忙,请稍后再试"];
//                    break;
//            }
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            DLog(@"%@",resp.accessToken);
//            NSMutableDictionary *parame = [NSMutableDictionary new];
//            parame[@"access_token"] = resp.accessToken;
//
//            //accessToken 登录
//            [FGHttpManager postWithPath:@"api/authorizations/socials/weixin" parameters:parame success:^(id responseObject) {
//
//                //获取用户信息
//                NSString *token = objectForKey(responseObject, @"access_token");
//                if (!IsEmpty(token)) {
//                    [FGCacheManager sharedInstance].token = token;
//
//                    //获取用户信息
//                    [FGUserHelper requestUserModelWithResult:^(BOOL success, NSString *error) {
//                        StrongSelf
//                        if (success) {
//                            [self hideLoadingHUD];
//                            [self.navigationController popViewControllerAnimated:YES];
//                            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSucceedNotification object:self userInfo:nil];
//                        }else{
//                            [self showWarningHUDWithMessage:error completion:nil];
//                        }
//
//                    }];
//                }
//
//            } failure:^(NSString *error) {
//                [self showWarningHUDWithMessage:error completion:nil];
//            }];
//        }
//    }];
//}


#pragma mark - navigation set

- (void)backItemClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
