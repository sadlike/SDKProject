//
//  HWGet.h
//  HyWin
//
//  Created by wwp on 2017/3/14.
//  Copyright © 2017年 wwp. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MyInformationModel.h"
#import <HYBaseF/SDevice.h>

#define RETURN_SUCCESS @"000000"   //成功
//#define RETURN_NOTLOGIN @"000002"  //未登陆
#define RETURN_TOKEN_TIMEOUT @"000001" //  token 超时
#define THROUGH  @"00" //审核通过    //可以下单
#define NOT_THROUGH  @"01" //审核不通过  不可以下单
#define THROUGH_AUDIT  @"02"//审核中  //可以下单
@interface HWGet : NSObject
@property (nonatomic,assign) BOOL isLogin;//判断是否登陆
@property (nonatomic,strong) NSString *loginAccount;//登陆的手机号
@property (nonatomic,strong) NSString *passWord;//登陆密码
@property (nonatomic,strong) NSString *remberPassWord;//是否记住密码 1记住。0 不记住
@property (nonatomic,strong) NSString *token;//验证码.
@property (nonatomic,strong) NSString *customerId;//客户的id;
//@property (nonatomic,strong) MyInformationModel *informationModel;//个人信息。

@property (nonatomic,strong) NSString *publicKeyStr;
@property (nonatomic,strong) NSArray *areaModelArray;
@property (nonatomic,strong) NSArray *hostArray;//服务器地址
@property (nonatomic,strong) NSArray *hotCityArray;//热门城市
@property (nonatomic,strong) SDevice *device;




+(NSString*) getHWDocPath;
-(void)writeMessageToPlistWithAccount:(NSString *)account password:(NSString *)password;
/**
 *  储存字符串到🔑钥匙串
 *
 *  @param sValue 对应的Value
 *  @param sKey   对应的Key
 */
+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;

/**
 *  从🔑钥匙串获取字符串
 *
 *  @param sKey 对应的Key
 *
 *  @return 返回储存的Value
 */
+ (NSString *)readKeychainValue:(NSString *)sKey;

/**
 *  从🔑钥匙串删除字符串
 *
 *  @param sKey 对应的Key
 */
+ (void)deleteKeychainValue:(NSString *)sKey;

@end

extern HWGet *hwSaveCache;
