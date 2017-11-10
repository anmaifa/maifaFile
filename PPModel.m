//
// PPModel.m 
//
// Created By 安美发 Version: 2.0
// Copyright (C) 2017/08/26  By AnMeiFa  All rights reserved.
// email:// 917524965@qq.com  tel:// +86 13682465601 
//
//

#import "PPConfig.h"
#import "PPModel.h"


@implementation OObject

- (id)init {
    self = [super init];
    if (!self) {
        CCLOG(@"%@   初始化失败", NSStringFromClass([self class]));
    }
    return self;
}

+ (id)parseFromDictionary:(NSDictionary *)sender {
    if (![sender isKindOfClass:[NSDictionary class]]) {
        CCLOG(@"Product +++++++++++++++MODEL+++++++++++++ 解析非字典类");
        return [self init];
    }
    return [[[[self class] alloc] init] parseFromDictionary:sender];
}

- (id)parseFromDictionary:(NSDictionary *)sender {
    if (![self init]) {
        CCLOG(@"Product +++++++++++++++MODEL+++++++++++++ 初始化失败");
    }
    if (![sender isKindOfClass:[NSDictionary class]]) {
        CCLOG(@"Product +++++++++++++++MODEL+++++++++++++ 解析非字典类");
        return self;
    }
    return self;
}


- (NSMutableDictionary *)dictionaryValue {
    NSMutableDictionary *dictionaryValue = [[NSMutableDictionary alloc] init];
    return dictionaryValue;
}

- (BOOL)saveForKey:(NSString *)sender {
    NSDictionary *dictionaryValue = [self dictionaryValue];
    [[NSUserDefaults standardUserDefaults] setObject:dictionaryValue forKey:sender];
    BOOL saveResult = [[NSUserDefaults standardUserDefaults] synchronize];
    return saveResult;
}

+ (id)findForKey:(NSString *)sender {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:sender]) {
        return nil;
    }
    NSDictionary *findDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:sender];
    if (![findDictionary isKindOfClass:[NSDictionary class]]) {
        CCLOG(@"Product +++++++++++++++MODEL+++++++++++++ 查找数据出错");
        return nil;
    }
    OObject *findResult = [[self class] parseFromDictionary:findDictionary];
    return findResult;
}


- (id)copyWithZone:(NSZone *)zone {
    OObject *copyObject = [[self class] allocWithZone:zone];
    [self copyOperationWithObject:copyObject];
    return copyObject;
}

- (void)copyOperationWithObject:(id)object {
}


static OObject *shareObject = nil;
+ (id)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObject = [[[self class] alloc] init];
    });
    return shareObject;
}

+(NSString *)initialDB {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dirPath = [NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory , NSUserDomainMask , YES) lastObject], @"DB"];
        BOOL isDir = NO;
        bool existed = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir];
        if (!(isDir == YES && existed == YES)) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        ((OObject *)[OObject shareInstance]).dbPath = [NSString stringWithFormat:@"%@/database.db", dirPath];
    });
    return ((OObject *)[OObject shareInstance]).dbPath;
}

@end



@implementation CityCollection

@synthesize ret;// 状态码，0表示成功，非0表示失败
@synthesize dataList;
//城市列表
- (id)init {
	self = [super init];
	if (self) {
		self.ret = -1;
		self.dataList = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (CityCollection *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		citycollectionShareObject = [[[self class] alloc] init];
	});
	return citycollectionShareObject;
}

- (CityCollection *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.ret = [sender int32ForKey:@"ret"];
	if ([sender hasKey:@"data"]) {
		for (id object in [sender arrayForKey:@"data"]) {
			if (object && [object isKindOfClass:[NSDictionary class]]) {
				City *item = (City *)[City parseFromDictionary:object];
				[self.dataList addObject:item];
			}
			else if (object && [object isKindOfClass:[NSArray class]]) {
				if (((NSArray *)object).count > 0 && [((NSArray *)object)[0] isKindOfClass:[NSDictionary class]]) {
					City *item = (City *)[City parseFromDictionary:((NSArray *)object)[0]];
					[self.dataList addObject:item];
				}
				else {
					City *item = (City *)[City parseFromDictionary:@{}];
					[self.dataList addObject:item];
				}
			}
		}
	}
	else if ([sender hasKey:@"data"] && [[sender dictionaryForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
		City *item = (City *)[City parseFromDictionary:[sender objectForKey:@"data"]];
		[self.dataList addObject:item];
	}
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.ret] forKey:@"ret"];
	NSMutableArray *dataItems = [[NSMutableArray alloc] init];
	for (City *item in self.dataList) {
		[dataItems addObject:[item dictionaryValue]];
	}
	[dictionaryValue setObj:dataItems forKey:@"data"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(CityCollection *)object {
		object.ret = self.ret;
		object.dataList = [[NSMutableArray alloc] initWithArray:self.dataList copyItems:YES];
}


@end


@implementation City

@synthesize sysPositionCityId;// 城市ID
@synthesize sysPositionProvinceId;// 省份ID
@synthesize name;//地址
@synthesize pinyinFull;//全拼
@synthesize pinyin;//简拼
@synthesize createTime;//创建时间
@synthesize updateTime;//更新时间

- (id)init {
	self = [super init];
	if (self) {
		self.sysPositionCityId = 0;
		self.sysPositionProvinceId = 0;
		self.name = @"";
		self.pinyinFull = @"";
		self.pinyin = @"";
		self.createTime = @"";
		self.updateTime = 0;
	}
	return self;
}

+ (City *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		cityShareObject = [[[self class] alloc] init];
	});
	return cityShareObject;
}

- (City *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.sysPositionCityId = [sender int32ForKey:@"sysPositionCityId"];
	self.sysPositionProvinceId = [sender int32ForKey:@"sysPositionProvinceId"];
	self.name = [sender stringForKey:@"name"];
	self.pinyinFull = [sender stringForKey:@"pinyinFull"];
	self.pinyin = [sender stringForKey:@"pinyin"];
	self.createTime = [sender stringForKey:@"createTime"];
	self.updateTime = [sender int32ForKey:@"updateTime"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.sysPositionCityId] forKey:@"sysPositionCityId"];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.sysPositionProvinceId] forKey:@"sysPositionProvinceId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.pinyinFull forKey:@"pinyinFull"];
	[dictionaryValue setObj:self.pinyin forKey:@"pinyin"];
	[dictionaryValue setObj:self.createTime forKey:@"createTime"];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.updateTime] forKey:@"updateTime"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(City *)object {
		object.sysPositionCityId = self.sysPositionCityId;
		object.sysPositionProvinceId = self.sysPositionProvinceId;
		object.name = self.name;
		object.pinyinFull = self.pinyinFull;
		object.pinyin = self.pinyin;
		object.createTime = self.createTime;
		object.updateTime = self.updateTime;
}


@end


@implementation ZuFangListCollection

@synthesize ret;// 状态码，0表示成功，非0表示失败
@synthesize dataList;
//城市列表
- (id)init {
	self = [super init];
	if (self) {
		self.ret = -1;
		self.dataList = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (ZuFangListCollection *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		zufanglistcollectionShareObject = [[[self class] alloc] init];
	});
	return zufanglistcollectionShareObject;
}

- (ZuFangListCollection *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.ret = [sender int32ForKey:@"ret"];
	if ([sender hasKey:@"data"]) {
		for (id object in [sender arrayForKey:@"data"]) {
			if (object && [object isKindOfClass:[NSDictionary class]]) {
				House *item = (House *)[House parseFromDictionary:object];
				[self.dataList addObject:item];
			}
			else if (object && [object isKindOfClass:[NSArray class]]) {
				if (((NSArray *)object).count > 0 && [((NSArray *)object)[0] isKindOfClass:[NSDictionary class]]) {
					House *item = (House *)[House parseFromDictionary:((NSArray *)object)[0]];
					[self.dataList addObject:item];
				}
				else {
					House *item = (House *)[House parseFromDictionary:@{}];
					[self.dataList addObject:item];
				}
			}
		}
	}
	else if ([sender hasKey:@"data"] && [[sender dictionaryForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
		House *item = (House *)[House parseFromDictionary:[sender objectForKey:@"data"]];
		[self.dataList addObject:item];
	}
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.ret] forKey:@"ret"];
	NSMutableArray *dataItems = [[NSMutableArray alloc] init];
	for (House *item in self.dataList) {
		[dataItems addObject:[item dictionaryValue]];
	}
	[dictionaryValue setObj:dataItems forKey:@"data"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(ZuFangListCollection *)object {
		object.ret = self.ret;
		object.dataList = [[NSMutableArray alloc] initWithArray:self.dataList copyItems:YES];
}


@end


@implementation House

@synthesize houseZufangDataId;// 房号ID
@synthesize name;//名称
@synthesize community;//小区
@synthesize position;//位置
@synthesize floor;// 楼层
@synthesize totalFloor;//总楼层
@synthesize area;//面积
@synthesize houseAllocationList;
//房屋配置（是一个数组）@synthesize rent;//租金
@synthesize contact;//联系人
@synthesize phone;//联系电话
@synthesize refreshTime;//刷新时间
@synthesize sysPositionCity;//城市ID
@synthesize sysPositionArea;//区域ID
@synthesize sysPositionCommercialArea;//商圈ID
@synthesize houseZufangImgFront;//商圈ID
@synthesize houseZufangBathroom;//卫
@synthesize houseZufangBedroom;//室
@synthesize houseZufangContactRole;//联系人类型
@synthesize houseZufangDepositMethod;//押金方式
@synthesize houseZufangHall;//厅
@synthesize houseZufangHouseType;//房屋类型
@synthesize houseZufangOrientation;//朝向
@synthesize houseZufangPriceRange;//价格区间
@synthesize houseZufangRenovation;//装修情况
@synthesize houseZufangRentModel;//出租方式
@synthesize houseZufangRentRoom;//出租间
@synthesize houseZufangTenantRequest;//租客要求

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangDataId = 0;
		self.name = @"";
		self.community = @"";
		self.position = @"";
		self.floor = 0;
		self.totalFloor = 0;
		self.area = 0;
		self.houseAllocationList = [[NSMutableArray alloc] init];
		self.rent = 0;
		self.contact = @"";
		self.phone = @"";
		self.refreshTime = @"";
		self.sysPositionCity = [[SysPositionCity alloc] init];
		self.sysPositionArea = [[SysPositionArea alloc] init];
		self.sysPositionCommercialArea = [[SysPositionCommercialArea alloc] init];
		self.houseZufangImgFront = [[HouseZufangImgFront alloc] init];
		self.houseZufangBathroom = @"";
		self.houseZufangBedroom = @"";
		self.houseZufangContactRole = [[HouseZufangContactRole alloc] init];
		self.houseZufangDepositMethod = @"";
		self.houseZufangHall = [[HouseZufangHall alloc] init];
		self.houseZufangHouseType = [[HouseZufangHouseType alloc] init];
		self.houseZufangOrientation = @"";
		self.houseZufangPriceRange = [[HouseZufangPriceRange alloc] init];
		self.houseZufangRenovation = [[HouseZufangRenovation alloc] init];
		self.houseZufangRentModel = [[HouseZufangRentModel alloc] init];
		self.houseZufangRentRoom = @"";
		self.houseZufangTenantRequest = @"";
	}
	return self;
}

+ (House *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		houseShareObject = [[[self class] alloc] init];
	});
	return houseShareObject;
}

- (House *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangDataId = [sender int32ForKey:@"houseZufangDataId"];
	self.name = [sender stringForKey:@"name"];
	self.community = [sender stringForKey:@"community"];
	self.position = [sender stringForKey:@"position"];
	self.floor = [sender int32ForKey:@"floor"];
	self.totalFloor = [sender int32ForKey:@"totalFloor"];
	self.area = [sender CGFloatForKey:@"area"];
	if ([sender hasKey:@"houseAllocation"]) {
		[self.houseAllocationList addObjectsFromArray:[sender arrayForKey:@"houseAllocation"]];
	}
	else if ([sender hasKey:@"houseAllocation"] && [[sender dictionaryForKey:@"houseAllocation"] isKindOfClass:[NSDictionary class]]) {
		[self.houseAllocationList addObject:[sender arrayForKey:@"houseAllocation"]];
	}
	self.rent = [sender CGFloatForKey:@"rent"];
	self.contact = [sender stringForKey:@"contact"];
	self.phone = [sender stringForKey:@"phone"];
	self.refreshTime = [sender stringForKey:@"refreshTime"];
	if ([sender hasKey:@"sysPositionCity"] && [[sender dictionaryForKey:@"sysPositionCity"] isKindOfClass:[NSDictionary class]]) {
		self.sysPositionCity = (SysPositionCity *)[SysPositionCity parseFromDictionary:[sender dictionaryForKey:@"sysPositionCity"]];
	}
	if ([sender hasKey:@"sysPositionCity"] && [[sender stringForKey:@"sysPositionCity"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"sysPositionCity"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.sysPositionCity = (SysPositionCity *)[SysPositionCity parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"sysPositionArea"] && [[sender dictionaryForKey:@"sysPositionArea"] isKindOfClass:[NSDictionary class]]) {
		self.sysPositionArea = (SysPositionArea *)[SysPositionArea parseFromDictionary:[sender dictionaryForKey:@"sysPositionArea"]];
	}
	if ([sender hasKey:@"sysPositionArea"] && [[sender stringForKey:@"sysPositionArea"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"sysPositionArea"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.sysPositionArea = (SysPositionArea *)[SysPositionArea parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"sysPositionCommercialArea"] && [[sender dictionaryForKey:@"sysPositionCommercialArea"] isKindOfClass:[NSDictionary class]]) {
		self.sysPositionCommercialArea = (SysPositionCommercialArea *)[SysPositionCommercialArea parseFromDictionary:[sender dictionaryForKey:@"sysPositionCommercialArea"]];
	}
	if ([sender hasKey:@"sysPositionCommercialArea"] && [[sender stringForKey:@"sysPositionCommercialArea"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"sysPositionCommercialArea"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.sysPositionCommercialArea = (SysPositionCommercialArea *)[SysPositionCommercialArea parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"houseZufangImgFront"] && [[sender dictionaryForKey:@"houseZufangImgFront"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangImgFront = (HouseZufangImgFront *)[HouseZufangImgFront parseFromDictionary:[sender dictionaryForKey:@"houseZufangImgFront"]];
	}
	if ([sender hasKey:@"houseZufangImgFront"] && [[sender stringForKey:@"houseZufangImgFront"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangImgFront"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangImgFront = (HouseZufangImgFront *)[HouseZufangImgFront parseFromDictionary:dic];
		}
	}
	self.houseZufangBathroom = [sender stringForKey:@"houseZufangBathroom"];
	self.houseZufangBedroom = [sender stringForKey:@"houseZufangBedroom"];
	if ([sender hasKey:@"houseZufangContactRole"] && [[sender dictionaryForKey:@"houseZufangContactRole"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangContactRole = (HouseZufangContactRole *)[HouseZufangContactRole parseFromDictionary:[sender dictionaryForKey:@"houseZufangContactRole"]];
	}
	if ([sender hasKey:@"houseZufangContactRole"] && [[sender stringForKey:@"houseZufangContactRole"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangContactRole"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangContactRole = (HouseZufangContactRole *)[HouseZufangContactRole parseFromDictionary:dic];
		}
	}
	self.houseZufangDepositMethod = [sender stringForKey:@"houseZufangDepositMethod"];
	if ([sender hasKey:@"houseZufangHall"] && [[sender dictionaryForKey:@"houseZufangHall"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangHall = (HouseZufangHall *)[HouseZufangHall parseFromDictionary:[sender dictionaryForKey:@"houseZufangHall"]];
	}
	if ([sender hasKey:@"houseZufangHall"] && [[sender stringForKey:@"houseZufangHall"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangHall"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangHall = (HouseZufangHall *)[HouseZufangHall parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"houseZufangHouseType"] && [[sender dictionaryForKey:@"houseZufangHouseType"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangHouseType = (HouseZufangHouseType *)[HouseZufangHouseType parseFromDictionary:[sender dictionaryForKey:@"houseZufangHouseType"]];
	}
	if ([sender hasKey:@"houseZufangHouseType"] && [[sender stringForKey:@"houseZufangHouseType"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangHouseType"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangHouseType = (HouseZufangHouseType *)[HouseZufangHouseType parseFromDictionary:dic];
		}
	}
	self.houseZufangOrientation = [sender stringForKey:@"houseZufangOrientation"];
	if ([sender hasKey:@"houseZufangPriceRange"] && [[sender dictionaryForKey:@"houseZufangPriceRange"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangPriceRange = (HouseZufangPriceRange *)[HouseZufangPriceRange parseFromDictionary:[sender dictionaryForKey:@"houseZufangPriceRange"]];
	}
	if ([sender hasKey:@"houseZufangPriceRange"] && [[sender stringForKey:@"houseZufangPriceRange"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangPriceRange"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangPriceRange = (HouseZufangPriceRange *)[HouseZufangPriceRange parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"houseZufangRenovation"] && [[sender dictionaryForKey:@"houseZufangRenovation"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangRenovation = (HouseZufangRenovation *)[HouseZufangRenovation parseFromDictionary:[sender dictionaryForKey:@"houseZufangRenovation"]];
	}
	if ([sender hasKey:@"houseZufangRenovation"] && [[sender stringForKey:@"houseZufangRenovation"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangRenovation"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangRenovation = (HouseZufangRenovation *)[HouseZufangRenovation parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"houseZufangRentModel"] && [[sender dictionaryForKey:@"houseZufangRentModel"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangRentModel = (HouseZufangRentModel *)[HouseZufangRentModel parseFromDictionary:[sender dictionaryForKey:@"houseZufangRentModel"]];
	}
	if ([sender hasKey:@"houseZufangRentModel"] && [[sender stringForKey:@"houseZufangRentModel"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangRentModel"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangRentModel = (HouseZufangRentModel *)[HouseZufangRentModel parseFromDictionary:dic];
		}
	}
	self.houseZufangRentRoom = [sender stringForKey:@"houseZufangRentRoom"];
	self.houseZufangTenantRequest = [sender stringForKey:@"houseZufangTenantRequest"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.houseZufangDataId] forKey:@"houseZufangDataId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.community forKey:@"community"];
	[dictionaryValue setObj:self.position forKey:@"position"];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.floor] forKey:@"floor"];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.totalFloor] forKey:@"totalFloor"];
	[dictionaryValue setObj:[NSNumber numberWithFloat:self.area] forKey:@"area"];
	[dictionaryValue setObj:self.houseAllocationList forKey:@"houseAllocation"];
	[dictionaryValue setObj:[NSNumber numberWithFloat:self.rent] forKey:@"rent"];
	[dictionaryValue setObj:self.contact forKey:@"contact"];
	[dictionaryValue setObj:self.phone forKey:@"phone"];
	[dictionaryValue setObj:self.refreshTime forKey:@"refreshTime"];
	[dictionaryValue setObj:[self.sysPositionCity dictionaryValue] forKey:@"sysPositionCity"];
	[dictionaryValue setObj:[self.sysPositionArea dictionaryValue] forKey:@"sysPositionArea"];
	[dictionaryValue setObj:[self.sysPositionCommercialArea dictionaryValue] forKey:@"sysPositionCommercialArea"];
	[dictionaryValue setObj:[self.houseZufangImgFront dictionaryValue] forKey:@"houseZufangImgFront"];
	[dictionaryValue setObj:self.houseZufangBathroom forKey:@"houseZufangBathroom"];
	[dictionaryValue setObj:self.houseZufangBedroom forKey:@"houseZufangBedroom"];
	[dictionaryValue setObj:[self.houseZufangContactRole dictionaryValue] forKey:@"houseZufangContactRole"];
	[dictionaryValue setObj:self.houseZufangDepositMethod forKey:@"houseZufangDepositMethod"];
	[dictionaryValue setObj:[self.houseZufangHall dictionaryValue] forKey:@"houseZufangHall"];
	[dictionaryValue setObj:[self.houseZufangHouseType dictionaryValue] forKey:@"houseZufangHouseType"];
	[dictionaryValue setObj:self.houseZufangOrientation forKey:@"houseZufangOrientation"];
	[dictionaryValue setObj:[self.houseZufangPriceRange dictionaryValue] forKey:@"houseZufangPriceRange"];
	[dictionaryValue setObj:[self.houseZufangRenovation dictionaryValue] forKey:@"houseZufangRenovation"];
	[dictionaryValue setObj:[self.houseZufangRentModel dictionaryValue] forKey:@"houseZufangRentModel"];
	[dictionaryValue setObj:self.houseZufangRentRoom forKey:@"houseZufangRentRoom"];
	[dictionaryValue setObj:self.houseZufangTenantRequest forKey:@"houseZufangTenantRequest"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(House *)object {
		object.houseZufangDataId = self.houseZufangDataId;
		object.name = self.name;
		object.community = self.community;
		object.position = self.position;
		object.floor = self.floor;
		object.totalFloor = self.totalFloor;
		object.area = self.area;
		object.houseAllocationList = [[NSMutableArray alloc] initWithArray:self.houseAllocationList copyItems:YES];
		object.rent = self.rent;
		object.contact = self.contact;
		object.phone = self.phone;
		object.refreshTime = self.refreshTime;
		object.sysPositionCity = self.sysPositionCity.copy;
		object.sysPositionArea = self.sysPositionArea.copy;
		object.sysPositionCommercialArea = self.sysPositionCommercialArea.copy;
		object.houseZufangImgFront = self.houseZufangImgFront.copy;
		object.houseZufangBathroom = self.houseZufangBathroom;
		object.houseZufangBedroom = self.houseZufangBedroom;
		object.houseZufangContactRole = self.houseZufangContactRole.copy;
		object.houseZufangDepositMethod = self.houseZufangDepositMethod;
		object.houseZufangHall = self.houseZufangHall.copy;
		object.houseZufangHouseType = self.houseZufangHouseType.copy;
		object.houseZufangOrientation = self.houseZufangOrientation;
		object.houseZufangPriceRange = self.houseZufangPriceRange.copy;
		object.houseZufangRenovation = self.houseZufangRenovation.copy;
		object.houseZufangRentModel = self.houseZufangRentModel.copy;
		object.houseZufangRentRoom = self.houseZufangRentRoom;
		object.houseZufangTenantRequest = self.houseZufangTenantRequest;
}


@end


@implementation HouseDetail

@synthesize houseZufangDataId;// 房号ID
@synthesize name;//名称
@synthesize community;//小区
@synthesize position;//位置
@synthesize title;//标题
@synthesize description;//描述
@synthesize keywords;//描述
@synthesize floor;// 楼层
@synthesize totalFloor;//总楼层
@synthesize area;//面积
@synthesize houseAllocationList;
//房屋配置（是一个数组）@synthesize rent;//租金
@synthesize contact;//联系人
@synthesize phone;//联系电话
@synthesize details;//详情
@synthesize viewTimes;//
@synthesize refreshTime;//刷新时间
@synthesize createTime;//创建时间
@synthesize updateTime;//更新时间
@synthesize houseZufangImgDetailsList;
//@synthesize sysPositionCity;//城市ID
@synthesize sysPositionArea;//区域ID
@synthesize sysPositionCommercialArea;//商圈ID
@synthesize houseZufangImgFront;//商圈ID
@synthesize houseZufangBathroom;//卫
@synthesize houseZufangBedroom;//室
@synthesize houseZufangContactRole;//联系人类型
@synthesize houseZufangDepositMethod;//押金方式
@synthesize houseZufangHall;//厅
@synthesize houseZufangHouseType;//房屋类型
@synthesize houseZufangOrientation;//朝向
@synthesize houseZufangPriceRange;//价格区间
@synthesize houseZufangRenovation;//装修情况
@synthesize houseZufangRentModel;//出租方式
@synthesize houseZufangRentRoom;//出租间
@synthesize houseZufangTenantRequest;//租客要求

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangDataId = 0;
		self.name = @"";
		self.community = @"";
		self.position = @"";
		self.title = @"";
		self.description = @"";
		self.keywords = @"";
		self.floor = 0;
		self.totalFloor = 0;
		self.area = 0;
		self.houseAllocationList = [[NSMutableArray alloc] init];
		self.rent = 0;
		self.contact = @"";
		self.phone = @"";
		self.details = @"";
		self.viewTimes = @"";
		self.refreshTime = @"";
		self.createTime = @"";
		self.updateTime = @"";
		self.houseZufangImgDetailsList = [[NSMutableArray alloc] init];
		self.sysPositionCity = [[SysPositionCity alloc] init];
		self.sysPositionArea = [[SysPositionArea alloc] init];
		self.sysPositionCommercialArea = [[SysPositionCommercialArea alloc] init];
		self.houseZufangImgFront = [[HouseZufangImgFront alloc] init];
		self.houseZufangBathroom = @"";
		self.houseZufangBedroom = @"";
		self.houseZufangContactRole = [[HouseZufangContactRole alloc] init];
		self.houseZufangDepositMethod = @"";
		self.houseZufangHall = [[HouseZufangHall alloc] init];
		self.houseZufangHouseType = [[HouseZufangHouseType alloc] init];
		self.houseZufangOrientation = @"";
		self.houseZufangPriceRange = [[HouseZufangPriceRange alloc] init];
		self.houseZufangRenovation = [[HouseZufangRenovation alloc] init];
		self.houseZufangRentModel = [[HouseZufangRentModel alloc] init];
		self.houseZufangRentRoom = @"";
		self.houseZufangTenantRequest = @"";
	}
	return self;
}

+ (HouseDetail *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housedetailShareObject = [[[self class] alloc] init];
	});
	return housedetailShareObject;
}

- (HouseDetail *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangDataId = [sender int32ForKey:@"houseZufangDataId"];
	self.name = [sender stringForKey:@"name"];
	self.community = [sender stringForKey:@"community"];
	self.position = [sender stringForKey:@"position"];
	self.title = [sender stringForKey:@"title"];
	self.description = [sender stringForKey:@"description"];
	self.keywords = [sender stringForKey:@"keywords"];
	self.floor = [sender int32ForKey:@"floor"];
	self.totalFloor = [sender int32ForKey:@"totalFloor"];
	self.area = [sender CGFloatForKey:@"area"];
	if ([sender hasKey:@"houseAllocation"]) {
		[self.houseAllocationList addObjectsFromArray:[sender arrayForKey:@"houseAllocation"]];
	}
	else if ([sender hasKey:@"houseAllocation"] && [[sender dictionaryForKey:@"houseAllocation"] isKindOfClass:[NSDictionary class]]) {
		[self.houseAllocationList addObject:[sender arrayForKey:@"houseAllocation"]];
	}
	self.rent = [sender CGFloatForKey:@"rent"];
	self.contact = [sender stringForKey:@"contact"];
	self.phone = [sender stringForKey:@"phone"];
	self.details = [sender stringForKey:@"details"];
	self.viewTimes = [sender stringForKey:@"viewTimes"];
	self.refreshTime = [sender stringForKey:@"refreshTime"];
	self.createTime = [sender stringForKey:@"createTime"];
	self.updateTime = [sender stringForKey:@"updateTime"];
	if ([sender hasKey:@"houseZufangImgDetails"]) {
		for (id object in [sender arrayForKey:@"houseZufangImgDetails"]) {
			if (object && [object isKindOfClass:[NSDictionary class]]) {
				HouseZufangImgDetails *item = (HouseZufangImgDetails *)[HouseZufangImgDetails parseFromDictionary:object];
				[self.houseZufangImgDetailsList addObject:item];
			}
			else if (object && [object isKindOfClass:[NSArray class]]) {
				if (((NSArray *)object).count > 0 && [((NSArray *)object)[0] isKindOfClass:[NSDictionary class]]) {
					HouseZufangImgDetails *item = (HouseZufangImgDetails *)[HouseZufangImgDetails parseFromDictionary:((NSArray *)object)[0]];
					[self.houseZufangImgDetailsList addObject:item];
				}
				else {
					HouseZufangImgDetails *item = (HouseZufangImgDetails *)[HouseZufangImgDetails parseFromDictionary:@{}];
					[self.houseZufangImgDetailsList addObject:item];
				}
			}
		}
	}
	else if ([sender hasKey:@"houseZufangImgDetails"] && [[sender dictionaryForKey:@"houseZufangImgDetails"] isKindOfClass:[NSDictionary class]]) {
		HouseZufangImgDetails *item = (HouseZufangImgDetails *)[HouseZufangImgDetails parseFromDictionary:[sender objectForKey:@"houseZufangImgDetails"]];
		[self.houseZufangImgDetailsList addObject:item];
	}
	if ([sender hasKey:@"sysPositionCity"] && [[sender dictionaryForKey:@"sysPositionCity"] isKindOfClass:[NSDictionary class]]) {
		self.sysPositionCity = (SysPositionCity *)[SysPositionCity parseFromDictionary:[sender dictionaryForKey:@"sysPositionCity"]];
	}
	if ([sender hasKey:@"sysPositionCity"] && [[sender stringForKey:@"sysPositionCity"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"sysPositionCity"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.sysPositionCity = (SysPositionCity *)[SysPositionCity parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"sysPositionArea"] && [[sender dictionaryForKey:@"sysPositionArea"] isKindOfClass:[NSDictionary class]]) {
		self.sysPositionArea = (SysPositionArea *)[SysPositionArea parseFromDictionary:[sender dictionaryForKey:@"sysPositionArea"]];
	}
	if ([sender hasKey:@"sysPositionArea"] && [[sender stringForKey:@"sysPositionArea"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"sysPositionArea"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.sysPositionArea = (SysPositionArea *)[SysPositionArea parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"sysPositionCommercialArea"] && [[sender dictionaryForKey:@"sysPositionCommercialArea"] isKindOfClass:[NSDictionary class]]) {
		self.sysPositionCommercialArea = (SysPositionCommercialArea *)[SysPositionCommercialArea parseFromDictionary:[sender dictionaryForKey:@"sysPositionCommercialArea"]];
	}
	if ([sender hasKey:@"sysPositionCommercialArea"] && [[sender stringForKey:@"sysPositionCommercialArea"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"sysPositionCommercialArea"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.sysPositionCommercialArea = (SysPositionCommercialArea *)[SysPositionCommercialArea parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"houseZufangImgFront"] && [[sender dictionaryForKey:@"houseZufangImgFront"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangImgFront = (HouseZufangImgFront *)[HouseZufangImgFront parseFromDictionary:[sender dictionaryForKey:@"houseZufangImgFront"]];
	}
	if ([sender hasKey:@"houseZufangImgFront"] && [[sender stringForKey:@"houseZufangImgFront"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangImgFront"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangImgFront = (HouseZufangImgFront *)[HouseZufangImgFront parseFromDictionary:dic];
		}
	}
	self.houseZufangBathroom = [sender stringForKey:@"houseZufangBathroom"];
	self.houseZufangBedroom = [sender stringForKey:@"houseZufangBedroom"];
	if ([sender hasKey:@"houseZufangContactRole"] && [[sender dictionaryForKey:@"houseZufangContactRole"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangContactRole = (HouseZufangContactRole *)[HouseZufangContactRole parseFromDictionary:[sender dictionaryForKey:@"houseZufangContactRole"]];
	}
	if ([sender hasKey:@"houseZufangContactRole"] && [[sender stringForKey:@"houseZufangContactRole"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangContactRole"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangContactRole = (HouseZufangContactRole *)[HouseZufangContactRole parseFromDictionary:dic];
		}
	}
	self.houseZufangDepositMethod = [sender stringForKey:@"houseZufangDepositMethod"];
	if ([sender hasKey:@"houseZufangHall"] && [[sender dictionaryForKey:@"houseZufangHall"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangHall = (HouseZufangHall *)[HouseZufangHall parseFromDictionary:[sender dictionaryForKey:@"houseZufangHall"]];
	}
	if ([sender hasKey:@"houseZufangHall"] && [[sender stringForKey:@"houseZufangHall"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangHall"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangHall = (HouseZufangHall *)[HouseZufangHall parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"houseZufangHouseType"] && [[sender dictionaryForKey:@"houseZufangHouseType"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangHouseType = (HouseZufangHouseType *)[HouseZufangHouseType parseFromDictionary:[sender dictionaryForKey:@"houseZufangHouseType"]];
	}
	if ([sender hasKey:@"houseZufangHouseType"] && [[sender stringForKey:@"houseZufangHouseType"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangHouseType"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangHouseType = (HouseZufangHouseType *)[HouseZufangHouseType parseFromDictionary:dic];
		}
	}
	self.houseZufangOrientation = [sender stringForKey:@"houseZufangOrientation"];
	if ([sender hasKey:@"houseZufangPriceRange"] && [[sender dictionaryForKey:@"houseZufangPriceRange"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangPriceRange = (HouseZufangPriceRange *)[HouseZufangPriceRange parseFromDictionary:[sender dictionaryForKey:@"houseZufangPriceRange"]];
	}
	if ([sender hasKey:@"houseZufangPriceRange"] && [[sender stringForKey:@"houseZufangPriceRange"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangPriceRange"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangPriceRange = (HouseZufangPriceRange *)[HouseZufangPriceRange parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"houseZufangRenovation"] && [[sender dictionaryForKey:@"houseZufangRenovation"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangRenovation = (HouseZufangRenovation *)[HouseZufangRenovation parseFromDictionary:[sender dictionaryForKey:@"houseZufangRenovation"]];
	}
	if ([sender hasKey:@"houseZufangRenovation"] && [[sender stringForKey:@"houseZufangRenovation"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangRenovation"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangRenovation = (HouseZufangRenovation *)[HouseZufangRenovation parseFromDictionary:dic];
		}
	}
	if ([sender hasKey:@"houseZufangRentModel"] && [[sender dictionaryForKey:@"houseZufangRentModel"] isKindOfClass:[NSDictionary class]]) {
		self.houseZufangRentModel = (HouseZufangRentModel *)[HouseZufangRentModel parseFromDictionary:[sender dictionaryForKey:@"houseZufangRentModel"]];
	}
	if ([sender hasKey:@"houseZufangRentModel"] && [[sender stringForKey:@"houseZufangRentModel"] isKindOfClass:[NSString class]]) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *) [sender stringForKey:@"houseZufangRentModel"]) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
		if ([dic isKindOfClass:[NSDictionary class]]) {
			self.houseZufangRentModel = (HouseZufangRentModel *)[HouseZufangRentModel parseFromDictionary:dic];
		}
	}
	self.houseZufangRentRoom = [sender stringForKey:@"houseZufangRentRoom"];
	self.houseZufangTenantRequest = [sender stringForKey:@"houseZufangTenantRequest"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.houseZufangDataId] forKey:@"houseZufangDataId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.community forKey:@"community"];
	[dictionaryValue setObj:self.position forKey:@"position"];
	[dictionaryValue setObj:self.title forKey:@"title"];
	[dictionaryValue setObj:self.description forKey:@"description"];
	[dictionaryValue setObj:self.keywords forKey:@"keywords"];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.floor] forKey:@"floor"];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.totalFloor] forKey:@"totalFloor"];
	[dictionaryValue setObj:[NSNumber numberWithFloat:self.area] forKey:@"area"];
	[dictionaryValue setObj:self.houseAllocationList forKey:@"houseAllocation"];
	[dictionaryValue setObj:[NSNumber numberWithFloat:self.rent] forKey:@"rent"];
	[dictionaryValue setObj:self.contact forKey:@"contact"];
	[dictionaryValue setObj:self.phone forKey:@"phone"];
	[dictionaryValue setObj:self.details forKey:@"details"];
	[dictionaryValue setObj:self.viewTimes forKey:@"viewTimes"];
	[dictionaryValue setObj:self.refreshTime forKey:@"refreshTime"];
	[dictionaryValue setObj:self.createTime forKey:@"createTime"];
	[dictionaryValue setObj:self.updateTime forKey:@"updateTime"];
	NSMutableArray *houseZufangImgDetailsItems = [[NSMutableArray alloc] init];
	for (HouseZufangImgDetails *item in self.houseZufangImgDetailsList) {
		[houseZufangImgDetailsItems addObject:[item dictionaryValue]];
	}
	[dictionaryValue setObj:houseZufangImgDetailsItems forKey:@"houseZufangImgDetails"];
	[dictionaryValue setObj:[self.sysPositionCity dictionaryValue] forKey:@"sysPositionCity"];
	[dictionaryValue setObj:[self.sysPositionArea dictionaryValue] forKey:@"sysPositionArea"];
	[dictionaryValue setObj:[self.sysPositionCommercialArea dictionaryValue] forKey:@"sysPositionCommercialArea"];
	[dictionaryValue setObj:[self.houseZufangImgFront dictionaryValue] forKey:@"houseZufangImgFront"];
	[dictionaryValue setObj:self.houseZufangBathroom forKey:@"houseZufangBathroom"];
	[dictionaryValue setObj:self.houseZufangBedroom forKey:@"houseZufangBedroom"];
	[dictionaryValue setObj:[self.houseZufangContactRole dictionaryValue] forKey:@"houseZufangContactRole"];
	[dictionaryValue setObj:self.houseZufangDepositMethod forKey:@"houseZufangDepositMethod"];
	[dictionaryValue setObj:[self.houseZufangHall dictionaryValue] forKey:@"houseZufangHall"];
	[dictionaryValue setObj:[self.houseZufangHouseType dictionaryValue] forKey:@"houseZufangHouseType"];
	[dictionaryValue setObj:self.houseZufangOrientation forKey:@"houseZufangOrientation"];
	[dictionaryValue setObj:[self.houseZufangPriceRange dictionaryValue] forKey:@"houseZufangPriceRange"];
	[dictionaryValue setObj:[self.houseZufangRenovation dictionaryValue] forKey:@"houseZufangRenovation"];
	[dictionaryValue setObj:[self.houseZufangRentModel dictionaryValue] forKey:@"houseZufangRentModel"];
	[dictionaryValue setObj:self.houseZufangRentRoom forKey:@"houseZufangRentRoom"];
	[dictionaryValue setObj:self.houseZufangTenantRequest forKey:@"houseZufangTenantRequest"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseDetail *)object {
		object.houseZufangDataId = self.houseZufangDataId;
		object.name = self.name;
		object.community = self.community;
		object.position = self.position;
		object.title = self.title;
		object.description = self.description;
		object.keywords = self.keywords;
		object.floor = self.floor;
		object.totalFloor = self.totalFloor;
		object.area = self.area;
		object.houseAllocationList = [[NSMutableArray alloc] initWithArray:self.houseAllocationList copyItems:YES];
		object.rent = self.rent;
		object.contact = self.contact;
		object.phone = self.phone;
		object.details = self.details;
		object.viewTimes = self.viewTimes;
		object.refreshTime = self.refreshTime;
		object.createTime = self.createTime;
		object.updateTime = self.updateTime;
		object.houseZufangImgDetailsList = [[NSMutableArray alloc] initWithArray:self.houseZufangImgDetailsList copyItems:YES];
		object.sysPositionCity = self.sysPositionCity.copy;
		object.sysPositionArea = self.sysPositionArea.copy;
		object.sysPositionCommercialArea = self.sysPositionCommercialArea.copy;
		object.houseZufangImgFront = self.houseZufangImgFront.copy;
		object.houseZufangBathroom = self.houseZufangBathroom;
		object.houseZufangBedroom = self.houseZufangBedroom;
		object.houseZufangContactRole = self.houseZufangContactRole.copy;
		object.houseZufangDepositMethod = self.houseZufangDepositMethod;
		object.houseZufangHall = self.houseZufangHall.copy;
		object.houseZufangHouseType = self.houseZufangHouseType.copy;
		object.houseZufangOrientation = self.houseZufangOrientation;
		object.houseZufangPriceRange = self.houseZufangPriceRange.copy;
		object.houseZufangRenovation = self.houseZufangRenovation.copy;
		object.houseZufangRentModel = self.houseZufangRentModel.copy;
		object.houseZufangRentRoom = self.houseZufangRentRoom;
		object.houseZufangTenantRequest = self.houseZufangTenantRequest;
}


@end


@implementation SysPositionCity

@synthesize sysPositionCityId;//城市ID
@synthesize name;//名字
@synthesize sysPositionProvinceId;//省份的id

- (id)init {
	self = [super init];
	if (self) {
		self.sysPositionCityId = @"";
		self.name = @"";
		self.sysPositionProvinceId = @"";
	}
	return self;
}

+ (SysPositionCity *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		syspositioncityShareObject = [[[self class] alloc] init];
	});
	return syspositioncityShareObject;
}

- (SysPositionCity *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.sysPositionCityId = [sender stringForKey:@"sysPositionCityId"];
	self.name = [sender stringForKey:@"name"];
	self.sysPositionProvinceId = [sender stringForKey:@"sysPositionProvinceId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.sysPositionCityId forKey:@"sysPositionCityId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.sysPositionProvinceId forKey:@"sysPositionProvinceId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(SysPositionCity *)object {
		object.sysPositionCityId = self.sysPositionCityId;
		object.name = self.name;
		object.sysPositionProvinceId = self.sysPositionProvinceId;
}


@end


@implementation SysPositionArea

@synthesize sysPositionAreaId;//区域ID
@synthesize name;//名字
@synthesize sysPositionCityId;//城市的id

- (id)init {
	self = [super init];
	if (self) {
		self.sysPositionAreaId = @"";
		self.name = @"";
		self.sysPositionCityId = @"";
	}
	return self;
}

+ (SysPositionArea *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		syspositionareaShareObject = [[[self class] alloc] init];
	});
	return syspositionareaShareObject;
}

- (SysPositionArea *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.sysPositionAreaId = [sender stringForKey:@"sysPositionAreaId"];
	self.name = [sender stringForKey:@"name"];
	self.sysPositionCityId = [sender stringForKey:@"sysPositionCityId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.sysPositionAreaId forKey:@"sysPositionAreaId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.sysPositionCityId forKey:@"sysPositionCityId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(SysPositionArea *)object {
		object.sysPositionAreaId = self.sysPositionAreaId;
		object.name = self.name;
		object.sysPositionCityId = self.sysPositionCityId;
}


@end


@implementation SysPositionCommercialArea

@synthesize sysPositionCommercialAreaId;//商圈ID
@synthesize name;//名字
@synthesize sysPositionAreaId;//商圈id

- (id)init {
	self = [super init];
	if (self) {
		self.sysPositionCommercialAreaId = @"";
		self.name = @"";
		self.sysPositionAreaId = @"";
	}
	return self;
}

+ (SysPositionCommercialArea *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		syspositioncommercialareaShareObject = [[[self class] alloc] init];
	});
	return syspositioncommercialareaShareObject;
}

- (SysPositionCommercialArea *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.sysPositionCommercialAreaId = [sender stringForKey:@"sysPositionCommercialAreaId"];
	self.name = [sender stringForKey:@"name"];
	self.sysPositionAreaId = [sender stringForKey:@"sysPositionAreaId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.sysPositionCommercialAreaId forKey:@"sysPositionCommercialAreaId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.sysPositionAreaId forKey:@"sysPositionAreaId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(SysPositionCommercialArea *)object {
		object.sysPositionCommercialAreaId = self.sysPositionCommercialAreaId;
		object.name = self.name;
		object.sysPositionAreaId = self.sysPositionAreaId;
}


@end


@implementation HouseZufangImgFront

@synthesize houseZufangImgFrontId;//
@synthesize url;//
@synthesize alt;//

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangImgFrontId = @"";
		self.url = @"";
		self.alt = @"";
	}
	return self;
}

+ (HouseZufangImgFront *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housezufangimgfrontShareObject = [[[self class] alloc] init];
	});
	return housezufangimgfrontShareObject;
}

- (HouseZufangImgFront *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangImgFrontId = [sender stringForKey:@"houseZufangImgFrontId"];
	self.url = [sender stringForKey:@"url"];
	self.alt = [sender stringForKey:@"alt"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.houseZufangImgFrontId forKey:@"houseZufangImgFrontId"];
	[dictionaryValue setObj:self.url forKey:@"url"];
	[dictionaryValue setObj:self.alt forKey:@"alt"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseZufangImgFront *)object {
		object.houseZufangImgFrontId = self.houseZufangImgFrontId;
		object.url = self.url;
		object.alt = self.alt;
}


@end


@implementation HouseZufangImgDetails

@synthesize houseZufangImgDetailId;//
@synthesize url;//
@synthesize alt;//

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangImgDetailId = @"";
		self.url = @"";
		self.alt = @"";
	}
	return self;
}

+ (HouseZufangImgDetails *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housezufangimgdetailsShareObject = [[[self class] alloc] init];
	});
	return housezufangimgdetailsShareObject;
}

- (HouseZufangImgDetails *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangImgDetailId = [sender stringForKey:@"houseZufangImgDetailId"];
	self.url = [sender stringForKey:@"url"];
	self.alt = [sender stringForKey:@"alt"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.houseZufangImgDetailId forKey:@"houseZufangImgDetailId"];
	[dictionaryValue setObj:self.url forKey:@"url"];
	[dictionaryValue setObj:self.alt forKey:@"alt"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseZufangImgDetails *)object {
		object.houseZufangImgDetailId = self.houseZufangImgDetailId;
		object.url = self.url;
		object.alt = self.alt;
}


@end


@implementation HouseZufangContactRole

@synthesize houseZufangContactRoleId;//
@synthesize name;//
@synthesize houseZufangDicTypeId;//

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangContactRoleId = @"";
		self.name = @"";
		self.houseZufangDicTypeId = @"";
	}
	return self;
}

+ (HouseZufangContactRole *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housezufangcontactroleShareObject = [[[self class] alloc] init];
	});
	return housezufangcontactroleShareObject;
}

- (HouseZufangContactRole *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangContactRoleId = [sender stringForKey:@"houseZufangContactRoleId"];
	self.name = [sender stringForKey:@"name"];
	self.houseZufangDicTypeId = [sender stringForKey:@"houseZufangDicTypeId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.houseZufangContactRoleId forKey:@"houseZufangContactRoleId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.houseZufangDicTypeId forKey:@"houseZufangDicTypeId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseZufangContactRole *)object {
		object.houseZufangContactRoleId = self.houseZufangContactRoleId;
		object.name = self.name;
		object.houseZufangDicTypeId = self.houseZufangDicTypeId;
}


@end


@implementation HouseZufangHall

@synthesize houseZufangHallId;//
@synthesize name;//
@synthesize houseZufangDicTypeId;//

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangHallId = @"";
		self.name = @"";
		self.houseZufangDicTypeId = @"";
	}
	return self;
}

+ (HouseZufangHall *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housezufanghallShareObject = [[[self class] alloc] init];
	});
	return housezufanghallShareObject;
}

- (HouseZufangHall *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangHallId = [sender stringForKey:@"houseZufangHallId"];
	self.name = [sender stringForKey:@"name"];
	self.houseZufangDicTypeId = [sender stringForKey:@"houseZufangDicTypeId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.houseZufangHallId forKey:@"houseZufangHallId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.houseZufangDicTypeId forKey:@"houseZufangDicTypeId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseZufangHall *)object {
		object.houseZufangHallId = self.houseZufangHallId;
		object.name = self.name;
		object.houseZufangDicTypeId = self.houseZufangDicTypeId;
}


@end


@implementation HouseZufangHouseType

@synthesize houseZufangHouseTypeId;//
@synthesize name;//
@synthesize houseZufangDicTypeId;//

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangHouseTypeId = @"";
		self.name = @"";
		self.houseZufangDicTypeId = @"";
	}
	return self;
}

+ (HouseZufangHouseType *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housezufanghousetypeShareObject = [[[self class] alloc] init];
	});
	return housezufanghousetypeShareObject;
}

- (HouseZufangHouseType *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangHouseTypeId = [sender stringForKey:@"houseZufangHouseTypeId"];
	self.name = [sender stringForKey:@"name"];
	self.houseZufangDicTypeId = [sender stringForKey:@"houseZufangDicTypeId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.houseZufangHouseTypeId forKey:@"houseZufangHouseTypeId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.houseZufangDicTypeId forKey:@"houseZufangDicTypeId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseZufangHouseType *)object {
		object.houseZufangHouseTypeId = self.houseZufangHouseTypeId;
		object.name = self.name;
		object.houseZufangDicTypeId = self.houseZufangDicTypeId;
}


@end


@implementation HouseZufangPriceRange

@synthesize houseZufangPriceRangeId;//
@synthesize name;//
@synthesize houseZufangDicTypeId;//

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangPriceRangeId = @"";
		self.name = @"";
		self.houseZufangDicTypeId = @"";
	}
	return self;
}

+ (HouseZufangPriceRange *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housezufangpricerangeShareObject = [[[self class] alloc] init];
	});
	return housezufangpricerangeShareObject;
}

- (HouseZufangPriceRange *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangPriceRangeId = [sender stringForKey:@"houseZufangPriceRangeId"];
	self.name = [sender stringForKey:@"name"];
	self.houseZufangDicTypeId = [sender stringForKey:@"houseZufangDicTypeId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.houseZufangPriceRangeId forKey:@"houseZufangPriceRangeId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.houseZufangDicTypeId forKey:@"houseZufangDicTypeId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseZufangPriceRange *)object {
		object.houseZufangPriceRangeId = self.houseZufangPriceRangeId;
		object.name = self.name;
		object.houseZufangDicTypeId = self.houseZufangDicTypeId;
}


@end


@implementation HouseZufangRenovation

@synthesize houseZufangRenovationId;//
@synthesize name;//
@synthesize houseZufangDicTypeId;//

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangRenovationId = @"";
		self.name = @"";
		self.houseZufangDicTypeId = @"";
	}
	return self;
}

+ (HouseZufangRenovation *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housezufangrenovationShareObject = [[[self class] alloc] init];
	});
	return housezufangrenovationShareObject;
}

- (HouseZufangRenovation *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangRenovationId = [sender stringForKey:@"houseZufangRenovationId"];
	self.name = [sender stringForKey:@"name"];
	self.houseZufangDicTypeId = [sender stringForKey:@"houseZufangDicTypeId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.houseZufangRenovationId forKey:@"houseZufangRenovationId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.houseZufangDicTypeId forKey:@"houseZufangDicTypeId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseZufangRenovation *)object {
		object.houseZufangRenovationId = self.houseZufangRenovationId;
		object.name = self.name;
		object.houseZufangDicTypeId = self.houseZufangDicTypeId;
}


@end


@implementation HouseZufangRentModel

@synthesize houseZufangRentModelId;//
@synthesize name;//
@synthesize houseZufangDicTypeId;//

- (id)init {
	self = [super init];
	if (self) {
		self.houseZufangRentModelId = @"";
		self.name = @"";
		self.houseZufangDicTypeId = @"";
	}
	return self;
}

+ (HouseZufangRentModel *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		housezufangrentmodelShareObject = [[[self class] alloc] init];
	});
	return housezufangrentmodelShareObject;
}

- (HouseZufangRentModel *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.houseZufangRentModelId = [sender stringForKey:@"houseZufangRentModelId"];
	self.name = [sender stringForKey:@"name"];
	self.houseZufangDicTypeId = [sender stringForKey:@"houseZufangDicTypeId"];
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:self.houseZufangRentModelId forKey:@"houseZufangRentModelId"];
	[dictionaryValue setObj:self.name forKey:@"name"];
	[dictionaryValue setObj:self.houseZufangDicTypeId forKey:@"houseZufangDicTypeId"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(HouseZufangRentModel *)object {
		object.houseZufangRentModelId = self.houseZufangRentModelId;
		object.name = self.name;
		object.houseZufangDicTypeId = self.houseZufangDicTypeId;
}


@end


@implementation ZufangDetailsCollection

@synthesize ret;// 状态码，0表示成功，非0表示失败
@synthesize dataList;
//城市列表
- (id)init {
	self = [super init];
	if (self) {
		self.ret = -1;
		self.dataList = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (ZufangDetailsCollection *)shareInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		zufangdetailscollectionShareObject = [[[self class] alloc] init];
	});
	return zufangdetailscollectionShareObject;
}

- (ZufangDetailsCollection *)parseFromDictionary:(NSDictionary *)sender {
	[super parseFromDictionary:sender];
	self.ret = [sender int32ForKey:@"ret"];
	if ([sender hasKey:@"data"]) {
		for (id object in [sender arrayForKey:@"data"]) {
			if (object && [object isKindOfClass:[NSDictionary class]]) {
				HouseDetail *item = (HouseDetail *)[HouseDetail parseFromDictionary:object];
				[self.dataList addObject:item];
			}
			else if (object && [object isKindOfClass:[NSArray class]]) {
				if (((NSArray *)object).count > 0 && [((NSArray *)object)[0] isKindOfClass:[NSDictionary class]]) {
					HouseDetail *item = (HouseDetail *)[HouseDetail parseFromDictionary:((NSArray *)object)[0]];
					[self.dataList addObject:item];
				}
				else {
					HouseDetail *item = (HouseDetail *)[HouseDetail parseFromDictionary:@{}];
					[self.dataList addObject:item];
				}
			}
		}
	}
	else if ([sender hasKey:@"data"] && [[sender dictionaryForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
		HouseDetail *item = (HouseDetail *)[HouseDetail parseFromDictionary:[sender objectForKey:@"data"]];
		[self.dataList addObject:item];
	}
	return self;
}


- (NSMutableDictionary *)dictionaryValue {
	NSMutableDictionary *dictionaryValue = [super dictionaryValue];
	[dictionaryValue setObj:[NSNumber numberWithInteger:self.ret] forKey:@"ret"];
	NSMutableArray *dataItems = [[NSMutableArray alloc] init];
	for (HouseDetail *item in self.dataList) {
		[dataItems addObject:[item dictionaryValue]];
	}
	[dictionaryValue setObj:dataItems forKey:@"data"];
	return dictionaryValue;
}

- (void)copyOperationWithObject:(ZufangDetailsCollection *)object {
		object.ret = self.ret;
		object.dataList = [[NSMutableArray alloc] initWithArray:self.dataList copyItems:YES];
}


@end
