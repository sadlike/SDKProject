//
//  SDevice.h
//  Wefafa
//
//  Created by ct on 15/12/23.
//  Copyright © 2015年 metersbonwe. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface SDevice : NSObject

// 设备唯一标识
@property (nonatomic,strong) NSString *deviceId;

//@property (nonatomic,strong) NSString *imei;
//@property (nonatomic,strong) NSString *mac;


@property (nonatomic,strong)NSString *appName;
// CFBundleShortVersionString
@property (nonatomic,strong) NSString *appVersionCode;

//CFBundleIdentifier
@property (nonatomic,strong) NSString *appCode;

// 设备设置的语言
@property (nonatomic,strong) NSString *appLanguage;

//设备设置的国家
@property (nonatomic,strong) NSString *appCountry;
//设备设置的时区
@property (nonatomic,strong) NSString *appTimeZone;

// 系统版本
@property (nonatomic,strong) NSString *osVersion;

// 系统名
@property (nonatomic,strong) NSString *osName;

// 当前设备的机器名称
@property (nonatomic,strong) NSString *model;

// 设备是否越狱
@property (nonatomic,assign) BOOL isJailBroke;

// 标记是iOS 还是 andrid   "ios"  "android"
@property (nonatomic,strong) NSString *osCode;

@end
