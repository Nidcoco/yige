//
//  FGForgetPasswordVC.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/5.
//

#import "FGForgetPasswordVC.h"
#import "FGCellStyleView.h"
#import "UIView+EdgeLine.h"
#import <JKCategories/NSString+JKNormalRegex.h>
#import <JKCategories/NSString+JKHash.h>
#import <UIButton+JKCountDown.h>


@interface FGForgetPasswordVC ()

@property (nonatomic, strong) FGCellStyleView *mobileView; ///< 手机号
@property (nonatomic, strong) FGCellStyleView *codeView; ///< 验证码
@property (nonatomic, strong) FGCellStyleView *pswView; ///< 密码
@property (nonatomic, strong) FGCellStyleView *againView;  ///< 确认密码
@property (nonatomic, strong) UIButton *getCodeBtn; ///< 发送验证码
@property (nonatomic, strong) UIButton *nextStepBtn; ///< 下一步

@property (nonatomic, copy) NSString *verificationKey;  ///< 验证码 确认key

@end

@implementation FGForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationView setNavigationBackgroundColor:UIColorFromHex(0xffffff)];
    
    FGTextFeidViewModel *model1 = [FGTextFeidViewModel new];
    model1.leftTitle = @"手机号";
    model1.keyboardType = UIKeyboardTypePhonePad;
    model1.placeholder = @"请输入11位手机号";
    model1.limitNum = 11;
    model1.contentMargin = AdaptedWidth(25);
    model1.contentFont = 18;
    self.mobileView = [[FGCellStyleView alloc] initWithModel:model1];
    [self.mobileView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView addSubview:self.mobileView];
    
    FGTextFeidViewModel *model2 = [FGTextFeidViewModel new];
    model2.leftTitle = @"验证码";
    model2.placeholder = @"输入验证码";
    model2.limitNum = 6;
    model2.contentFont = 18;
    model2.contentMargin = AdaptedWidth(25);
    model2.keyboardType = UIKeyboardTypeNumberPad;
    self.codeView = [[FGCellStyleView alloc] initWithModel:model2];
    self.codeView.textFeild.clearButtonMode = UITextFieldViewModeNever;
    [self.codeView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView addSubview:self.codeView];
    
    
    FGTextFeidViewModel *model3 = [FGTextFeidViewModel new];
    model3.leftTitle = @"密    码";
    model3.placeholder = @"请输入6-18位密码";
    model3.secureTextEntry = YES;
    model3.contentMargin = AdaptedWidth(25);
    model3.contentFont = 18;
    self.pswView = [[FGCellStyleView alloc] initWithModel:model3];
    [self.pswView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView  addSubview:self.pswView];
    
    FGTextFeidViewModel *model4 = [FGTextFeidViewModel new];
    model4.leftTitle = @"确认密码";
    model4.placeholder = @"请再输入6-18位密码";
    model4.secureTextEntry = YES;
    model4.contentMargin = AdaptedWidth(25);
    model4.contentFont = 18;
    self.againView = [[FGCellStyleView alloc] initWithModel:model4];
    [self.againView addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(6), 0, 0)];
    [self.bgScrollView.contentView  addSubview:self.againView];
    
    self.nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextStepBtn setImage:UIImageWithName(@"btn_confirm_yellow_1") forState:UIControlStateDisabled];
    [self.nextStepBtn setImage:UIImageWithName(@"btn_confirm_yellow_2") forState:UIControlStateNormal];
    [self.bgScrollView.contentView addSubview:self.nextStepBtn];
    [self.nextStepBtn addTarget:self action:@selector(netxStepAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn setTitle:@" 获取验证码 " forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = AdaptedFontSize(13);
    [self.getCodeBtn setTitleColor:UIColorFromHex(0xD37526) forState:UIControlStateNormal];
    self.getCodeBtn.layer.cornerRadius = AdaptedWidth(3);
    self.getCodeBtn.layer.borderColor = UIColorFromHex(0xD37526).CGColor;
    self.getCodeBtn.layer.borderWidth = 1;
    self.getCodeBtn.clipsToBounds = YES;
    [self.bgScrollView.contentView addSubview:self.getCodeBtn];
    [self.getCodeBtn addTarget:self action:@selector(startCountdown) forControlEvents:UIControlEventTouchUpInside];
    [self.getCodeBtn addBottomLine];
    
    
    RAC(self.nextStepBtn,enabled) = [[RACSignal combineLatest:@[[self.mobileView.textFeild rac_textSignal],[self.codeView.textFeild rac_textSignal] ,[self.pswView.textFeild rac_textSignal]]] map:^id _Nullable(RACTuple * _Nullable value) {
        RACTupleUnpack(NSString *tel, NSString *code , NSString *pwd ) = value;
        return @(tel.length == 11 && code.length > 3 && pwd.length > 5);
    }];
}

- (void)setupLayout
{
    [self.bgScrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenHeight - NavigationHeight_N());
    }];
    
    UILabel *label = [UILabel fg_text:@"忘记密码" fontSize:23 colorHex:0x333333];
    [self.bgScrollView.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(45));
        make.left.equalTo(self.bgScrollView.contentView ).offset(AdaptedWidth(34));
    }];
    
    [self.mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(AdaptedWidth(30));
        make.left.equalTo(self.bgScrollView.contentView).offset(AdaptedWidth(28));
        make.right.equalTo(self.bgScrollView.contentView).offset(-AdaptedWidth(34));
        make.height.mas_equalTo(AdaptedWidth(52));
    }];
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileView.mas_bottom).offset(AdaptedWidth(16));
        make.left.right.height.equalTo(self.mobileView);
    }];
    
    [self.pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeView.mas_bottom).offset(AdaptedWidth(16));
        make.left.right.height.equalTo(self.mobileView);
    }];
    
    [self.againView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pswView.mas_bottom).offset(AdaptedWidth(16));
        make.left.right.height.equalTo(self.mobileView);
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(AdaptedWidth(100));
        make.height.mas_equalTo(AdaptedWidth(32));
        make.centerY.equalTo(self.codeView.mas_centerY);
        make.right.equalTo(self.codeView.mas_right ).offset(0);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.againView.mas_bottom).offset(AdaptedWidth(66));
        make.centerX.equalTo(self.bgScrollView.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(355), AdaptedWidth(60)));
    }];
}

- (void)loginAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 下一步
 */
- (void)netxStepAction
{
    [self.view endEditing:YES];
    NSString *mobile = self.mobileView.model.content;
    NSString *code = self.codeView.model.content;
    NSString *password = self.pswView.model.content;
    NSString *againPassword = self.againView.model.content;
    
    if (![mobile jk_isMobileNumber]) {
        [self showWarningHUDWithMessage:@"输入的手机号码格式有误" completion:nil];
        return;
    }else if (code == nil || code == 0){
        [self showWarningHUDWithMessage:@"请获取验证码" completion:nil];
        return;
    }else if (code.length < 5) {
        [self showWarningHUDWithMessage:@"输入验证码有误" completion:nil];
        return;
    }else if (password.length < 6) {
        [self showWarningHUDWithMessage:@"密码不能小于6位" completion:nil];
        return;
    }else if (![password isEqualToString:againPassword]) {
        [self showWarningHUDWithMessage:@"两次输入的密码不一致" completion:nil];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"phone"] = mobile;
    dic[@"verification_code"] = code;
    dic[@"password" ] = [password jk_md5String];
    dic[@"verification_key"] = self.verificationKey;
    [self showLoadingHUDWithMessage:nil];
    WeakSelf
    [FGHttpManager postWithPath:@"api/users/resetPassword" parameters:dic success:^(id responseObject) {
        StrongSelf
        [self showTextHUDWithMessage:@"找回密码成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error) {
        StrongSelf
        [self showWarningHUDWithMessage:error completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startCountdown
{
    [self.view endEditing:YES];
    
    if (![self.mobileView.model.content jk_isMobileNumber]) {
        [self showWarningHUDWithMessage:@"输入的手机号码格式有误" completion:nil];
        return;
    }
    
    [self showLoadingHUDWithMessage:nil];
    self.getCodeBtn.titleLabel.font = AdaptedFontSize(13);
    WeakSelf
    //根据手机号查找用户名
    NSDictionary *dict = @{@"phone": self.mobileView.model.content,
                           @"type": @"reset_password"};
    
    [FGHttpManager postWithPath:@"api/captchas/sms" parameters:dict success:^(id responseObject) {
        StrongSelf
        [self showTextHUDWithMessage:@"发送成功，请留意手机短信"];
        self.verificationKey = objectForKey(responseObject, @"key");
        [self.getCodeBtn jk_startTime:59 title:@"获取验证码" waitTittle:@"重新获取"];
    } failure:^(NSString *error) {
        StrongSelf
        [self showWarningHUDWithMessage:error completion:nil];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
