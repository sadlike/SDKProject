//
//  NSString+SAdditions.h
//  Wefafa
//
//  Created by ct on 15/10/28.
//  Copyright © 2015年 metersbonwe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SAdditions)

/**
 *  字符串转 json object
 *
 *  @return an json object
 */
-(NSObject *)jsonObject;

/**
 *  获取第一个字母
 *
 *  @return
 */
-(NSString *)firstLetter;

/**
 *  取出前后空格
 *
 *  @return 
 */
-(NSString *)trimString;

/**
 *  生成GET请求的url
 *
 *  @param params
 *
 *  @return
 */
-(NSString *)generalURLWithParams:(NSDictionary *)params;

/**
 *  把  NSData 转换成 十六进制的 NSString
 *
 *  @param data
 *
 *  @return
 */
+(NSString *)NSDataToHexString:(NSData *)data;


/**
 *  十六进制字符串转bytes
 *
 *  @param hexStr
 *
 *  @return
 */
+(NSData *)hexStringToNSData:(NSString *)hexStr;

/**
 *  是否为空串
 *
 *  @return
 */
+(BOOL)isEmpty:(NSString *)str;


/**
 *  判断两个对象是否一样 这个一样包括 都为空  都不为空 但值相等
 *
 *  @param source
 *  @param destString
 *
 *  @return
 */
+(BOOL)isSameValueBetweenSourceString:(NSString *)source andDestString:(NSString *)dest;


@end
