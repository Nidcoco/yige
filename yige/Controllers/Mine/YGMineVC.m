//
//  YGMineVC.m
//  yige
//
//  Created by 李俊宇 on 2019/2/26.
//  Copyright © 2019 LiJunYu. All rights reserved.
//

#import "YGMineVC.h"
#import "FGCellStyleView.h"
#import "FGGroupBtnsView.h"

#import "YGSetVC.h"

@interface YGMineVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *headerBackground;  ///< <#Description#>
@property (nonatomic) CGFloat originHeight;

@property (nonatomic, strong) UIImageView *avatatImageView;  ///< <#Description#>
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) FGGroupBtnsView *groupBtns;

@end

@implementation YGMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"我的"];
    
    self.navigationView.lineView.hidden = YES;
    
    [self blockMethod];
}


#pragma mark - LifeCicle(生命周期)

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Target Mehtods(事件方法)

#pragma mark - Block(Block回调)

- (void)blockMethod
{
    WeakSelf
    [self.loginBtn jk_addActionHandler:^(NSInteger tag) {
        StrongSelf
        if (![FGUserHelper isLogin:self]) {
            return;
        }
    }];
    
    
    self.avatatImageView.userInteractionEnabled = YES;
    [self.avatatImageView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        StrongSelf
        //        if (![FGUserHelper isLogin:self]) {
        //            return;
        //        }

    }];
}

#pragma mark - Request Methods(网络请求)

#pragma mark - Private Methods(私有方法)


//我的礼包
- (void)orderAction
{
//    LHOrderManagerVC *vc = [LHOrderManagerVC new];
//    [self.navigationController pushViewController:vc animated:YES];
}

// 订单入口
- (void)orderActionWithIndex:(NSInteger)index
{
//    LHOrderManagerVC *vc = [LHOrderManagerVC new];
//    vc.orderListType = index + 1;
//    [self.navigationController pushViewController:vc animated:YES];
}

//cell的点击事件
- (void)cellStyleAction:(FGCellStyleView *)view
{
    NSString *title = view.model.leftTitle;
    if([title isEqualToString:@"设置"]) {
        YGSetVC *vc = [YGSetVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //    if (![FGUserHelper isLogin:self]) {
    //        return;
    //    }
//    if([title isEqualToString:@"我的积分"]) {
//        LHMyIntegralVC *vc = [LHMyIntegralVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if([title isEqualToString:@"我的等级"]) {
//        LHMyLevelVC *vc = [LHMyLevelVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if([title isEqualToString:@"我的特权"]) {
//        LHMyPrivilegeVC *vc = [LHMyPrivilegeVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if([title isEqualToString:@"我的分享"]) {
//        LHMyShareVC *vc = [LHMyShareVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}

#pragma mark - Public Methods(公有方法)

#pragma mark - Observer(监听事件)

#pragma mark - Delegate(代理)

#pragma mark - UI(UI创建)

//初始化
- (void)setupViews
{
    self.bgScrollView.delegate = self;
    
    self.headerBackground = [UIView new];
    [self.bgScrollView.contentView addSubview:self.headerBackground];
    [self.headerBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.top.right.offset(0);
//        make.height.offset(AdaptedHeight(121));
    }];
    
    UIImageView *vgBackground = [UIImageView fg_imageString:@"bg_mine_black"];
//    vgBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerBackground addSubview:vgBackground];
    self.originHeight = vgBackground.image.size.height * kScreenWidth /  vgBackground.image.size.width;
    [vgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.offset(0);
    }];
    
    self.avatatImageView = [UIImageView fg_imageString:@"img_mine_top_the_default_avatar"];
    [self.headerBackground addSubview:self.avatatImageView];
    [self.avatatImageView fg_cornerRadius:AdaptedWidth(42) borderWidth:AdaptedWidth(5) borderColor:0x999999];
    [self.avatatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(AdaptedWidth(84));
        make.centerY.offset(0);
        make.left.offset(AdaptedWidth(22));
    }];
    
    _loginBtn = [UIButton fg_title:@"登录  |  注册" fontSize:17 titleColorHex:0xFFFFFF];
    _loginBtn.titleLabel.font = AdaptedBoldFontSize(17);
    [self.headerBackground addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(self.avatatImageView.mas_right).offset(AdaptedWidth(29));
        make.height.offset(AdaptedWidth(17));
        make.right.mas_lessThanOrEqualTo(0);
    }];
    
    //我的订单
    FGTextFeidViewModel *orderModel = [FGTextFeidViewModel new];
    orderModel.leftTitle = @"  我的订单";
    orderModel.leftTitleColor = UIColorFromHex(0x333333);
    orderModel.contentFont = 17;
    orderModel.rightImgPath = @"ic_arrow_right_dark_brown_middle";
    FGCellStyleView *orderView = [[FGCellStyleView alloc] initWithModel:orderModel];
    [orderView addBottomLineWithEdge:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [orderView addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchDown];
    [self.bgScrollView.contentView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerBackground.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(AdaptedWidth(50));
    }];
    
    NSArray *tempArray = @[@{@"titleString":@"待付款",@"imageString":@"img_mine_not_paying"},@{@"titleString":@"待发货",@"imageString":@"img_mine_not_to_deliver_goods"},@{@"titleString":@"待收货",@"imageString":@"ic_mine_not_receiving"},@{@"titleString":@"待评价",@"imageString":@"img_mine_no_evaluation"}];
    
    NSArray *array = [NSArray modelArrayWithClass:[FGGroupBtnsModel class] json:tempArray];
    
    self.groupBtns = [[FGGroupBtnsView alloc]initWithModel:array width:kScreenWidth column:4];
    
    self.groupBtns.tintColor = UIColorFromHex(0x333333);
    WeakSelf
    [self.groupBtns setDidSelectedIndex:^(NSInteger index, NSString *title) {
        StrongSelf
//        [self orderActionWithIndex:index];
    }];
    
    [self.bgScrollView.contentView addSubview:_groupBtns];
    [_groupBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(orderView.mas_bottom);
        make.height.mas_equalTo(AdaptedWidth(92));
    }];
    
    NSArray *dataArr = @[@"我的积分",  @"我的等级", @"我的特权", @"我的分享", @"设置"];
    NSArray *leftImageArr = @[@"ic_mine_setting",  @"ic_mine_setting", @"ic_mine_setting", @"ic_mine_setting", @"ic_mine_setting"];
    
    UIView *temp;
    for (NSInteger i = 0; i < dataArr.count; i ++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftImgPathMargin = AdaptedWidth(15);
        model.leftTitle = dataArr[i];
        model.leftImgPath = leftImageArr[i];
        model.leftTitleColor = UIColorFromHex(0x333333);
        model.rightImgPath = @"ic_arrow_right_dark_brown_middle";
        
        FGCellStyleView *view = [[FGCellStyleView alloc] initWithModel:model];
        [view addBottomLineWithEdge:UIEdgeInsetsMake(0, 0, 0, 0)];
        view.layer.borderColor = UIColorFromHexWithAlpha(0x333333, 0.1).CGColor;
        [view addTarget:self action:@selector(cellStyleAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgScrollView.contentView addSubview:view];
        
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(AdaptedWidth(50));
            if (i == 0) {
                make.top.equalTo(self.groupBtns.mas_bottom).offset(AdaptedWidth(7));
            }else if(i == 3){
                make.top.equalTo(temp.mas_bottom).offset(AdaptedWidth(7));
            }else if(i == 4){
                make.bottom.offset(0);
                make.top.equalTo(temp.mas_bottom);
            }else{
                make.top.equalTo(temp.mas_bottom);
            }
        }];
        temp = view;
    }
    

    
}
//约束
- (void)setupLayout
{
    
}

#pragma mark - header

//header的缩放效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [self.headerBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgScrollView.contentView);
        if (scrollView.contentOffset.y < 0) {
            make.top.equalTo(self.bgScrollView.contentView).offset(scrollView.contentOffset.y);
            make.height.mas_equalTo(self.originHeight - scrollView.contentOffset.y);
        }else{
            make.top.equalTo(self.bgScrollView.contentView);
            make.height.mas_equalTo(self.originHeight);
        }
    }];
}


#pragma mark - Setter & Getter

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
