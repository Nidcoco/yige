//
//  PopTableListView.m
//  PopView
//
//  Created by 李林 on 2018/2/28.
//  Copyright © 2018年 李林. All rights reserved.
//

#import "PopTableListView.h"

#import "PopTableListCell.h"

@interface PopTableListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,copy) NSArray *titles;
@property (nonatomic ,copy) NSArray *imgNames;


@end
@implementation PopTableListView
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles imgNames:(NSArray <NSString *>*)imgNames
{
    CGRect frame = CGRectMake(0, 0, AdaptedWidth(153),titles.count * 50 > kScreenHeight * 0.5 ? kScreenHeight * 0.5:titles.count * 50);
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.imgNames = imgNames;
        self.index = [NSIndexPath indexPathForRow:0 inSection:0]; //默认广州校区

        [self addSubview:self.tableView];
        self.backgroundColor = [UIColor whiteColor];
        [self  jk_shadowWithColor:UIColorFromHex(0x000000) offset:CGSizeMake(4, 4) opacity:0.2 radius:10];
        [self fg_cornerRadius:5 borderWidth:0 borderColor:0];
        
    }
    return self;
}

- (void)reloadDataWithTitles:(NSArray *)titles imgNames:(NSArray <NSString *>*)imgNames{
    self.titles = titles;
    self.imgNames = imgNames;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PopTableListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PopTableListCell class])];
    if (cell == nil) {
        cell = [[PopTableListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([PopTableListCell class])];
    }
    
    [cell configeTitle:[self.titles objectAtIndex:indexPath.row] image:self.imgNames[indexPath.row]];
//    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
//    cell.imageView.image = UIImageWithName(self.imgNames[indexPath.row]);
    
    if (self.index) {
        
        if (indexPath.row == self.index.row ) {
            //当前选中的颜色
            cell.selectTextColor = IsEmpty(self.selectColor)? self.normalColor : self.selectColor;
            //        cell.textLabel.textColor = IsEmpty(self.selectColor)? self.normalColor : self.selectColor;
            
        }else{
            //未选择的颜色
            cell.normalTextColor = IsEmpty(self.normalColor)? [UIColor blackColor]: self.normalColor;
            //        cell.textLabel.textColor = IsEmpty(self.normalColor)? [UIColor blackColor]: self.normalColor;
        }
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.index = indexPath;
    if (self.didselectItem) {
        self.didselectItem(self.titles[indexPath.row], indexPath);
    }
    
    [self.tableView reloadData];
    [PopView hidenPopView];
}



- (void)setIndex:(NSIndexPath *)index{
    _index = index;
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 50;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PopTableListCell class] forCellReuseIdentifier:NSStringFromClass([PopTableListCell class])];
    }
    return _tableView;
}

- (void)reloadTableView{
    [self.tableView reloadData];
}

- (void)messageRedPoint:(BOOL)show
{
    if (show) {
        PopTableListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell showRedPoint];
    }
}


@end
