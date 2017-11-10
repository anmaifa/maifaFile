//
// PPModel+DB.m 
//
// Created By 安美发 Version: 2.0
// Copyright (C) 2017/08/26  By AnMeiFa  All rights reserved.
// email:// 917524965@qq.com  tel:// +86 13682465601 
//
//

#import "PPConfig.h"
#import "PPModel+DB.h"

@implementation OObject(DB) 
- (BOOL)save {
	return NO;
}
- (BOOL)del {
	return NO;
}
+ (BOOL)delByConditions:(NSString *)sender {
	return NO;
}
- (BOOL)update {
	return NO;
}
+ (BOOL)updateByConditions:(NSString *)sender {
	return NO;
}
+ (NSArray *)findByConditions:(NSString *)sender {
	return [[NSMutableArray alloc] init];
}
+ (NSInteger)maxKeyValue {
	return 0;
}

@end


@implementation CityCollection(DB)


@end


@implementation City(DB)


@end


@implementation ZuFangListCollection(DB)


@end


@implementation House(DB)


@end


@implementation HouseDetail(DB)


@end


@implementation SysPositionCity(DB)


@end


@implementation SysPositionArea(DB)


@end


@implementation SysPositionCommercialArea(DB)


@end


@implementation HouseZufangImgFront(DB)


@end


@implementation HouseZufangImgDetails(DB)


@end


@implementation HouseZufangContactRole(DB)


@end


@implementation HouseZufangHall(DB)


@end


@implementation HouseZufangHouseType(DB)


@end


@implementation HouseZufangPriceRange(DB)


@end


@implementation HouseZufangRenovation(DB)


@end


@implementation HouseZufangRentModel(DB)


@end


@implementation ZufangDetailsCollection(DB)


@end
