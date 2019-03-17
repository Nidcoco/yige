//
//  FGUploadHelper.h
//  yulala
//
//  Created by Eric on 2018/11/9.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FGImagePickerVC.h"


@interface FGUploadResponseModel : FGBaseModel

@property (nonatomic, strong) NSNumber *user_id;  ///< <#Description#>

@property (nonatomic, copy) NSString *type;  ///< <#Description#>
@property (nonatomic, copy) NSString *path;  ///< <#Description#>
@property (nonatomic, copy) NSString *created_at;  ///< <#Description#>
@property (nonatomic, copy) NSString *updated_at;  ///< <#Description#>

@end

/**
 上传的图片类型
 */
typedef NS_ENUM(NSInteger,FGUploadImageType) {
    FGUploadImageTypeDefault, ///< 默认
    FGUploadImageTypeAvatar, ///< 头像
    FGUploadImageTypeProduct ///< 商品
};


@interface FGUploadHelper : NSObject

+ (void)uploadImageWithType:(FGUploadImageType)type image:(UIImage *)image progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                    success:(void (^)(FGUploadResponseModel *responesModel))success
                    failure:(void (^)(NSString *error))failure;

+ (void)uploadImagesWithType:(FGUploadImageType)type images:(NSArray<UIImage*> *)images progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                    success:(void (^)(NSArray<FGUploadResponseModel*> *responesModels))success
                    failure:(void (^)(NSString *error))failure;

+ (void)uploadFileWithFile:(NSString *)file progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                    success:(void (^)(FGUploadResponseModel *responesModel))success
                    failure:(void (^)(NSString *error))failure;


//+ (void)showSheetViewWithImagePicker:(FGImagePickerVC *)imagePicker;




@end
