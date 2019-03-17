//
//  PopTableListCell.m
//  dingdingxuefu
//
//  Created by chenjingwei on 2018/7/20.
//

#import "PopTableListCell.h"

@interface PopTableListCell()

@property (nonatomic, weak) UILabel *titleLabel;  ///< <#name#>
@property (nonatomic, weak) UIImageView *leftImageView;  ///< <#name#>

@property (nonatomic, strong) UIImageView *redPointImageView;  ///< 红点 imageView

@end
@implementation PopTableListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupViews];
        
    }
    return self;
}

- (void)setupViews{
    UIImageView *imageView = [UIImageView fg_imageString:nil];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.centerX.offset(-30);
    }];
    
    UILabel *titleLabel = [UILabel fg_text:nil fontSize:17 colorHex:0x00000];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(imageView.mas_right).offset(10);
    }];
    
    self.redPointImageView = [UIImageView fg_imageString:@"ic_circle_tips_red_small"];
    [self.contentView addSubview:self.redPointImageView];
    [self.redPointImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(titleLabel.mas_right).offset(AdaptedWidth(16));
        make.width.height.offset(AdaptedWidth(8));
    }];
    self.redPointImageView.hidden = YES;
    
    self.leftImageView = imageView;
    self.titleLabel = titleLabel;
}

- (void)configeTitle:(NSString *)title image:(NSString *)image{
    if (!image) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
    }else{
        self.leftImageView.image = UIImageWithName(image);
    }
    
    self.titleLabel.text = title;
    
}

- (void)setNormalTextColor:(UIColor *)normalTextColor{
    self.titleLabel.textColor = normalTextColor;
}

- (void)setSelectTextColor:(UIColor *)selectTextColor{
    self.titleLabel.textColor = selectTextColor;
}

- (void)showRedPoint
{
    self.redPointImageView.hidden = NO;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    if (self.imageView.image) {
//        self.imageView.jk_centerX = self.contentView.jk_centerX - 20;
//        self.textLabel.jk_left = self.imageView.jk_right + 10;
//    }else{
//        self.textLabel.centerX = self.jk_centerX;
//    }
//
//}

@end
