//
//  YGTabBarVC.m
//  yige
//
//  Created by 李俊宇 on 2019/2/26.
//  Copyright © 2019 YangWeiCong. All rights reserved.
//

#import "YGTabBarVC.h"

@interface YGTabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *normalImageNameArray;
@property (nonatomic,strong)NSMutableArray *selectedImageNameArray;



@end

@implementation YGTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //统一调整 导航栏 设置
    EasyNavigationOptions *options = [EasyNavigationOptions shareInstance];
    options.titleColor = UIColorFromHex(0xFFFFFF);
    options.titleFont = [UIFont systemFontOfSize:19];
//    options.navigationBackButtonImage = [UIImage imageNamed:@"ic_arrow_left_return_gray@3x"];
    options.buttonTitleColor = UIColorFromHex(0xFFFFFF);
    options.navBackGroundColor = UIColorFromHex(0x2e2e2e);
    
    
    self.titleArray = [NSMutableArray arrayWithArray:@[@"首页",@"艺格",@"购物车", @"我的"]];
    
    NSMutableArray *arrNavi = [[NSMutableArray alloc]init];
    NSArray *arrVC = @[@"YGHomeVC",@"YGYiGeVC",@"YGShoppingCarVC",@"YGMineVC"];
    for (int i = 0; i < arrVC.count; i++) {
        UIViewController *viewController = [[NSClassFromString(arrVC[i]) alloc]init];
        FGBaseNavigationController *navi = [[FGBaseNavigationController alloc]initWithRootViewController:viewController];
        [arrNavi addObject:navi];
    }
    
    self.viewControllers = arrNavi;
    self.tabBar.translucent = NO;
    self.delegate = self;
    
    [self customizeTabBar];
}



- (void)customizeTabBar
{
    
    _normalImageNameArray = [NSMutableArray arrayWithArray:@[@"Home",@"Customer-Service", @"Shopping-Cart", @"Mine"]];
    _selectedImageNameArray = [NSMutableArray arrayWithArray:@[@"Home_Sel",@"Customer-Service_Sel",@"Shopping-Cart_Sel", @"Mine_Sel"]];
    
    NSUInteger index = 0;
    for (UINavigationController *navigationController in self.viewControllers) {
        
        UIViewController *viewController = navigationController.viewControllers.firstObject;
        
        NSString *title = self.titleArray[index];
        NSString *normalImageName = _normalImageNameArray[index];
        NSString *selectedImageName = _selectedImageNameArray[index];
        
        UIImage *normalImage = UIImageWithName(normalImageName);
        UIImage *selectedImage = UIImageWithName(selectedImageName);
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage tag:index];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromHex(0x666666)} forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromHex(0x2f2f2f)} forState:UIControlStateSelected];
        if ([normalImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        [tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        tabBarItem.image = normalImage;
        tabBarItem.selectedImage = selectedImage;
        
        viewController.tabBarItem = tabBarItem;
        
        index++;
    }
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
