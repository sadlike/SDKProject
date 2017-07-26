//
//  SBaseHandlerClass.h
//  Wefafa
//
//  Created by PHM on 11/18/15.
//  Copyright © 2015 metersbonwe. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, SBaseHandlerReturnType) {
    SBaseHandlerReturnTypeVerify,      //数据验证
    SBaseHandlerReturnTypeSuccess,      //数据操作成功
    SBaseHandlerReturnTypeAbnormal,     //数据操作异常
    SBaseHandlerReturnTypeFailed,       //网络获取失败(无网络)
    SBaseHandlerReturnTypeTimeout,      //网络获取失败(网络超时)
    SBaseHandlerReturnTypeNoData,       //获取数据为空
    SBaseHandlerReturnTypeNoMoreData,   //没有获取到更多数据  
};

typedef void (^baseHandlerReturnType)(SBaseHandlerReturnType type);

extern NSInteger SBaseHandlerClassPageSize; //一页大小
@interface SBaseHandlerClass : NSObject

@end
