//
// PPModel+DB.h 
//
// Created By 安美发 Version: 2.0
// Copyright (C) 2017/08/26  By AnMeiFa  All rights reserved.
// email:// 917524965@qq.com  tel:// +86 13682465601 
//
//

#import <FMDB/FMDatabase.h>
#import "PPModel.h"


@interface OObject(DB) {
}
- (BOOL)save;
- (BOOL)del;
+ (BOOL)delByConditions:(NSString *)sender;
- (BOOL)update;
+ (BOOL)updateByConditions:(NSString *)sender;
+ (NSArray *)findByConditions:(NSString *)sender;
+ (NSInteger)maxKeyValue;

@end


@interface CityCollection(DB) {
}

@end


@interface City(DB) {
}

@end


@interface ZuFangListCollection(DB) {
}

@end


@interface House(DB) {
}

@end


@interface HouseDetail(DB) {
}

@end


@interface SysPositionCity(DB) {
}

@end


@interface SysPositionArea(DB) {
}

@end


@interface SysPositionCommercialArea(DB) {
}

@end


@interface HouseZufangImgFront(DB) {
}

@end


@interface HouseZufangImgDetails(DB) {
}

@end


@interface HouseZufangContactRole(DB) {
}

@end


@interface HouseZufangHall(DB) {
}

@end


@interface HouseZufangHouseType(DB) {
}

@end


@interface HouseZufangPriceRange(DB) {
}

@end


@interface HouseZufangRenovation(DB) {
}

@end


@interface HouseZufangRentModel(DB) {
}

@end


@interface ZufangDetailsCollection(DB) {
}

@end
