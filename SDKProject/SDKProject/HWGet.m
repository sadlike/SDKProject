//
//  HWGet.m
//  HyWin
//
//  Created by wwp on 2017/3/14.
//  Copyright © 2017年 wwp. All rights reserved.
//

#import "HWGet.h"
HWGet *hwSaveCache;
static NSString * SETTINGFILENAME=@"hwsetting.plist";
@implementation HWGet
@synthesize loginAccount,passWord,areaModelArray,hostArray,hotCityArray;
-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
//获取document路径
+(NSString*) getHWDocPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[paths objectAtIndex:0];
    return documentPath;
}
-(void)writeMessageToPlistWithAccount:(NSString *)account password:(NSString *)password
{
    NSString *filepath = [[HWGet getHWDocPath] stringByAppendingPathComponent:@"HyWinSetting.plist"];
//    NSDictionary *curUser =@{
//                             @"loginAccount":[Utils getSNSString:account],
//                             @"passWord":[Utils getSNSString:password],
//                             @"remberPW":[Utils getSNSInteger:self.remberPassWord],
//                           };
//    NSDictionary *dic =@{[Utils getSNSString:account]:curUser};
//    //通过钥匙串存储
//    [HWGet saveKeychainValue:[Utils getSNSString:account] key:@"mobile_no"];
//    [HWGet saveKeychainValue:[Utils getSNSString:password] key:@"passWord"];
//    [HWGet saveKeychainValue:[Utils getSNSInteger:self.remberPassWord] key:@"remberPW"];
//    
//    NSMutableDictionary *cacheDic = [NSMutableDictionary dictionaryWithContentsOfFile:filepath];
//    [cacheDic setObject:dic forKey:[Utils getSNSString:account]];
//    [dic writeToFile:filepath atomically:YES];
    NSLog(@"---filePaht--%@",filepath);
    
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,
            (__bridge_transfer id)kSecClass,service,
            (__bridge_transfer id)kSecAttrService,service,
            (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
            (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey{
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:sValue] forKey:(__bridge_transfer id)kSecValueData];
    
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    
}

+ (NSString *)readKeychainValue:(NSString *)sKey
{
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", sKey, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}
+ (void)deleteKeychainValue:(NSString *)sKey {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

@end

