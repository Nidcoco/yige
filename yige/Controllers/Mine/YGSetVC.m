//
//  YGSetVC.m
//  yige
//
//  Created by 李俊宇 on 2019/2/26.
//  Copyright © 2019 LiJunYu. All rights reserved.
//

#import "YGSetVC.h"
#import "FGCellStyleView.h"

@interface YGSetVC ()

@end

@implementation YGSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"设置"];
}

//初始化
- (void)setupViews
{
    NSArray *titles = @[@"版本号",@"检查版本更新",@"退出登录"];
//    if (![FGUserHelper isToken]) {
//        titles = @[@"版本号",@"检查版本更新"];
//    }
    UIView *tempView;
    for (NSInteger i = 0; i < titles.count; i ++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftTitle = titles[i];
        model.leftImgPathMargin = AdaptedWidth(16);
        model.alignment = NSTextAlignmentRight;
        model.contentColor = UIColorFromHex(0x333333);
        if (i !=2) {
            model.rightImgPath = @"ic_arrow_right_dark_brown_middle";
            model.leftTitleColor = UIColorFromHex(0x333333);
        }else{
            model.leftTitleColor = UIColorFromHex(0xEC0808);
        }
        
        FGCellStyleView *view = [[FGCellStyleView alloc] initWithModel:model];
        [self.view addSubview:view];
        if (i == 2) {
            view.textFeild.enabled = NO;
        }
        [view addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(AdaptedWidth(45));
            if (i == 0) {
                make.top.equalTo(self.navigationView.mas_bottom);
            }
            else
                make.top.equalTo(tempView.mas_bottom).offset(AdaptedWidth(10));
        }];
        tempView = view;
    }
}


//- (void)clickAction:(FGCellStyleView *)view
//{
//    NSString *touchStr = view.model.leftTitle;
//    if ([touchStr isEqualToString:@"退出登录"]) {
//        FGAlertView *alert = [[FGAlertView alloc] initWithTitle:nil message:@"您确定要退出当前账号吗?" btnNames:@[@"取消",@"确定"]];
//        [alert show];
//        alert.didSelected = ^(BOOL isCancel) {
//            if (!isCancel) {
//                [FGUserHelper logout:^{
//                    [self showTextHUDWithMessage:@"退出成功"];
//                }];
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//        };
//        
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
