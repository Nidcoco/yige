//
//  APPConfig.h
//  figoioskit
//
//  Created by qiuxiaofeng on 2018/2/27.
//  Copyright © 2018年 qiuxiaofeng. All rights reserved.
//

#ifndef APPConfig_h
#define APPConfig_h

#pragma mark - UI Config
//controllerView默认背景色
static int const kColorBG = 0xf4f4f4;

//默认线条颜色
static int const kColorLine = 0xE0E0E0;

//主题颜色
static int const kColorTheme = 0xf2af17;
//==========================================================================================

/**
 *  开发环境配置 begin
 */

#pragma mark - 开关
/**
 *  需要手动更改的配置(发布正式环境包时要全部注释) begin
 */
#define Develop // 开发环境
//#define Relese //发布环境

//==========================================================================================

#pragma mark - 开发环境

#ifdef Develop

#define BaseApi @"http://api.test.store.piu.io"
//友盟分享
#define kUmengAppkey   @"59759f63aed1797c95000b0d"

//微信
#define kWechatAppKey  @"wx69c0efdec0b07d01"// 测试版
#define kWechatAppSecret  @"0e53dd3872783fdb923965ae2792d6c0"// 测试版

//QQ
#define kQQAppID  @"1106561886"// 测试版
#define kQQAppKey  @"moZeScTsf1J47gyd"// 测试版

//微博
#define kSinaAppId              @"857825842"
#define kSinaAppSecret          @"26e7aa2cfbd034b9bc9f8776f610b384"

//极光推送的发布环境
#define kJPushStatus NO

//阿里云OSS
#define OSS_DIMAO @"http://yc-cloud.oss-cn-shenzhen.aliyuncs.com"
#define OSS_BUCKET @"yc-cloud"

//apple id
#define kAppleId @"1049732608"      // (想见 测试用)

#define ApnsCerName @"meiyun_push_dev_inhouse"

#define NIMAppKey @"a4ac6d53594e42bb5fec5dafaa6388e4"

#define DDActivityUrl(ID) [NSString stringWithFormat:@"http://dingdingxuefu.figo.cn/index.html#/activity?id=%@",ID]
#define DDSchoolNewUrl(ID) [NSString stringWithFormat:@"http://dingdingxuefu.figo.cn/index.html#/schoolNews?id=%@",ID]
#define DDQuestionnaireUrl(ID) [NSString stringWithFormat:@"http://dingdingxuefu.figo.cn/index.html#/questionnaire?id=%@",ID]
#define DDDownloadUrl(name,code,url) IsEmpty(kUserId)?@"http://dingdingxuefu.figo.cn/index.html#/download":[NSString stringWithFormat:@"http://dingdingxuefu.figo.cn/index.html#/download?name=%@&code=%@&url=%@",name,code,url]

#endif


//==========================================================================================

#pragma mark - 发布环境

#ifdef Relese

#define BaseApi @"http://api.store.piu.io"

//友盟分享
#define kUmengAppkey   @"59759f63aed1797c95000b0d" // 正式版

//微信
#define kWechatAppKey  @"wx69c0efdec0b07d01"// 正式版
#define kWechatAppSecret  @"0e53dd3872783fdb923965ae2792d6c0"// 正式版

//QQ
#define kQQAppID  @"1106561886"// 正式版
#define kQQAppKey  @"moZeScTsf1J47gyd"// 正式版

//微博
#define kSinaAppId              @"857825842"
#define kSinaAppSecret          @"26e7aa2cfbd034b9bc9f8776f610b384"

//极光推送的发布环境
#define kJPushStatus YES

//阿里云OSS
#define OSS_DIMAO @"http://yc-cloud.oss-cn-shenzhen.aliyuncs.com"
#define OSS_BUCKET @"yc-cloud"

//apple id
#define kAppleId @"1318129281"      //美云

#define ApnsCerNameInhouse @"meiyunPushInhouseDis"
#define ApnsCerNameDis @"meiyunPushDis"

#define PushKitCerNameInhouse @"meiyunVoipInhouse"
#define PushKitCerNameDis @"meiyunVoipDis"

#define NIMAppKey @"60ef3ba7da8b045dd8e4689e515d9564"

#endif

//==========================================================================================

#pragma mark - 第三方平台的key

//极光推送
#define kJPushAppKey           @"8c1806f619dd07b6fe7fe347"
#define kJPushAppSecret       @"ce54320c5af410d047449955"
#define kJPushChannel          @"appstore"

#pragma mark - pingPP
#define kUrlScheme      @"ShuoNaiWuDing" // 这个是你定义的 URL Scheme，支付宝、微信支付

#pragma mark - 阿里云OSS
#define OSS_ACCESS_KEY @"LTAID8AnSpFaJIlc"
#define OSS_SECRET_KEY @"H7j1pX0hUymeGrqwXZDUQOp06YKLIL"
#define OSS_HOST @"oss-cn-shenzhen.aliyuncs.com"
#define OSS_AVATAR_DIR @"avatar" //头像上传目录
#define OSS_VIDEO_DIR @"video" //视频上传目录
#define OSS_OTHER_IMAGR_DIR @"image" //其他图片上传目录
#define OSS_VOICE_DIR @"" //上传的音频

//微信登录授权的baseurl
#define WX_BASE_URL @"https://api.weixin.qq.com/sns"

#endif /* APPConfig_h */
