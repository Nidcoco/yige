//
//  FGUploadHelper.m
//  yulala
//
//  Created by Eric on 2018/11/9.
//  Copyright © 2018 YangWeiCong. All rights reserved.
//

#import "FGUploadHelper.h"
#import "AppDelegate.h"

@implementation FGUploadResponseModel

@end

@implementation FGUploadHelper

+ (void)uploadImageWithType:(FGUploadImageType)type image:(UIImage *)image progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                    success:(void (^)(FGUploadResponseModel *responesModel))success
                    failure:(void (^)(NSString *error))failure
{
    
     UIViewController *viewContrller = kAppDelegate.window.rootViewController;
    onMainThreadAsync(^{
        [viewContrller showLoadingHUDWithMessage:@"上传图片中..."];
    });
    
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    NSMutableDictionary *parame = [NSMutableDictionary new];
    switch (type) {
        case FGUploadImageTypeDefault:{
            parame[@"type"] = @"default";
        }
            break;
        case FGUploadImageTypeAvatar:{
            parame[@"type"] = @"avatar";
        }
            break;
        case FGUploadImageTypeProduct:{
            parame[@"type"] = @"product";
        }
            break;
    }
    
    NSString *url = [BaseApi stringByAppendingString:@"/api/images"];
    [[FGHttpManager manager] POST:url parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       
        [formData appendPartWithFileData:data name:@"image" fileName:@"image" mimeType:@"png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadProgress = uploadProgress;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [viewContrller hideLoadingHUD];
        FGResponseModel *model = [FGResponseModel modelWithJSON:responseObject];
        if (model.code.integerValue == 0) {
            success([FGUploadResponseModel modelWithJSON:model.data]);
        }else{
            failure(model.msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [viewContrller hideLoadingHUD];
        failure(@"图片上传失败");
    }];
}

+ (void)uploadImagesWithType:(FGUploadImageType)type images:(NSArray<UIImage*> *)images progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                     success:(void (^)(NSArray<FGUploadResponseModel*> *responesModels))success
                     failure:(void (^)(NSString *error))failure
{
    UIViewController *viewContrller = kAppDelegate.window.rootViewController;
    
    [viewContrller showLoadingHUDWithMessage:@"上传图片中..."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *models = [NSMutableArray array];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        __block BOOL uplodImage = YES;
        
        for (UIImage *image in images) {
            if (uplodImage) {
                [FGUploadHelper uploadImageWithType:type image:image progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(FGUploadResponseModel *responesModel) {
                    [models addObject:responesModel];
                    dispatch_semaphore_signal(semaphore);
                } failure:^(NSString *error) {
                    uplodImage = NO;
                    dispatch_semaphore_signal(semaphore);
                    [viewContrller hideLoadingHUD];
                }];
            }
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        if (uplodImage == NO) {
            failure(@"图片上传失败啦");
            [viewContrller showTextHUDWithMessage:@"图片上传失败啦"];
            return;
        }
        success(models);
    });
    
}

+ (void)uploadFileWithFile:(NSString *)file progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                   success:(void (^)(FGUploadResponseModel *responesModel))success
                   failure:(void (^)(NSString *error))failure
{
    UIViewController *viewContrller = kAppDelegate.window.rootViewController;
    
    [viewContrller showLoadingHUDWithMessage:@"上传文件中..."];
    
    NSMutableDictionary *parame = [NSMutableDictionary new];
    parame[@"type"] = @"default";
    
    NSString *url = [BaseApi stringByAppendingString:@"/api/files"];
    [[FGHttpManager manager] POST:url parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL URLWithString:file] name:@"file" fileName:@"file" mimeType:@"" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadProgress = uploadProgress;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [viewContrller hideLoadingHUD];
        FGResponseModel *model = [FGResponseModel modelWithJSON:responseObject];
        if (model.code.integerValue == 0) {
            success([FGUploadResponseModel modelWithJSON:model.data]);
        }else{
            failure(model.msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [viewContrller hideLoadingHUD];
        failure(@"文件上传失败");
    }];
}

//+ (void)showSheetViewWithImagePicker:(FGImagePickerVC *)imagePicker
//{
//    
//    UIViewController *viewContrller = kAppDelegate.window.rootViewController;
//    
//    UIAlertController *alVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [alVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [imagePicker takePhoto];
//    }]];
//    [alVC addAction:[UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [imagePicker pushTZImagePickerController];
//    }]];
//    
//    [viewContrller presentViewController:alVC animated:YES completion:nil];
//
//}




@end
