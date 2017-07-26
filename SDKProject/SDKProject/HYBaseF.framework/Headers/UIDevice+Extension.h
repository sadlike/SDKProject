//
//  UIDevice+Extension.h
//  Wefafa
//
//  Created by ct on 15/12/23.
//  Copyright © 2015年 metersbonwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extension)


// 是否越狱
+(BOOL)isJailBrokeDevice;

// 设备描述
+(NSString*) model ;

@end
