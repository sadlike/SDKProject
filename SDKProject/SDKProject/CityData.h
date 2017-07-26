//
//  CityData.h
//  SDKProject
//
//  Created by wwp on 2017/7/20.
//  Copyright © 2017年 wwp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityData : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,assign) NSUInteger belowCount;
@property (nonatomic,strong,nullable) CityData *supermodel;
@property (nonatomic,strong) NSMutableArray * submodels;
+(instancetype)modelWithDic:(NSDictionary *)dic;
-(NSArray *)open;
-(void)closeWithSubmodels:(NSArray *)submodels;

@end
