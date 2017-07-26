//
//  CityData.m
//  SDKProject
//
//  Created by wwp on 2017/7/20.
//  Copyright © 2017年 wwp. All rights reserved.
//

#import "CityData.h"

@implementation CityData
+ (instancetype)modelWithDic:(NSDictionary *)dic {
    CityData *foldCellModel = [CityData new];
    foldCellModel.text = dic[@"text"];
    foldCellModel.level = dic[@"level"];
    foldCellModel.belowCount = 0;
    
    foldCellModel.submodels = [NSMutableArray new];
    NSArray *submodels = dic[@"submodels"];
    for (int i = 0; i < submodels.count; i++) {
        CityData *submodel = [CityData modelWithDic:(NSDictionary *)submodels[i]];
        submodel.supermodel = foldCellModel;
        [foldCellModel.submodels addObject:submodel];
    }
    
    return foldCellModel;
}

- (NSArray *)open {
    NSArray *submodels = self.submodels;
    self.submodels = nil;
    self.belowCount = submodels.count;
    return submodels;
}

- (void)closeWithSubmodels:(NSArray *)submodels {
    self.submodels = [NSMutableArray arrayWithArray:submodels];
    self.belowCount = 0;
}

- (void)setBelowCount:(NSUInteger)belowCount {
    self.supermodel.belowCount += (belowCount - _belowCount);
    _belowCount = belowCount;
}

@end
