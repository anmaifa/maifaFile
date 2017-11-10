//
// PPModel.h 
//
// Created By 安美发 Version: 2.0
// Copyright (C) 2017/08/26  By AnMeiFa  All rights reserved.
// email:// 917524965@qq.com  tel:// +86 13682465601 
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSDictionary+Safe.h"

typedef enum Code {
    Code_OK = 0,//操作成功。
} Code;


@class OObject;
@class CityCollection;
@class City;
@class ZuFangListCollection;
@class House;
@class HouseDetail;
@class SysPositionCity;
@class SysPositionArea;
@class SysPositionCommercialArea;
@class HouseZufangImgFront;
@class HouseZufangImgDetails;
@class HouseZufangContactRole;
@class HouseZufangHall;
@class HouseZufangHouseType;
@class HouseZufangPriceRange;
@class HouseZufangRenovation;
@class HouseZufangRentModel;
@class ZufangDetailsCollection;

static CityCollection *citycollectionShareObject = nil;
static City *cityShareObject = nil;
static ZuFangListCollection *zufanglistcollectionShareObject = nil;
static House *houseShareObject = nil;
static HouseDetail *housedetailShareObject = nil;
static SysPositionCity *syspositioncityShareObject = nil;
static SysPositionArea *syspositionareaShareObject = nil;
static SysPositionCommercialArea *syspositioncommercialareaShareObject = nil;
static HouseZufangImgFront *housezufangimgfrontShareObject = nil;
static HouseZufangImgDetails *housezufangimgdetailsShareObject = nil;
static HouseZufangContactRole *housezufangcontactroleShareObject = nil;
static HouseZufangHall *housezufanghallShareObject = nil;
static HouseZufangHouseType *housezufanghousetypeShareObject = nil;
static HouseZufangPriceRange *housezufangpricerangeShareObject = nil;
static HouseZufangRenovation *housezufangrenovationShareObject = nil;
static HouseZufangRentModel *housezufangrentmodelShareObject = nil;
static ZufangDetailsCollection *zufangdetailscollectionShareObject = nil;

@interface OObject : NSObject<NSCopying> {
}
@property (readwrite, nonatomic, strong) NSString *dbPath;

- (id)init;
+ (id)parseFromDictionary:(NSDictionary *)sender;
- (id)parseFromDictionary:(NSDictionary *)sender;

- (NSMutableDictionary *)dictionaryValue;
- (BOOL)saveForKey:(NSString *)sender;
+ (id)findForKey:(NSString *)sender;

- (id)copyWithZone:(NSZone *)zone;
- (void)copyOperationWithObject:(id)object;

+ (id)shareInstance;
+ (NSString *)initialDB;

@end


@interface CityCollection : OObject {
}
@property (readwrite, nonatomic, assign) NSInteger ret;// 状态码，0表示成功，非0表示失败
@property (readwrite, nonatomic, strong) NSMutableArray *dataList;//城市列表

- (id)init;
+ (CityCollection *)shareInstance;
- (CityCollection *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(CityCollection *)object;

@end


@interface City : OObject {
}
@property (readwrite, nonatomic, assign) NSInteger sysPositionCityId;// 城市ID
@property (readwrite, nonatomic, assign) NSInteger sysPositionProvinceId;// 省份ID
@property (readwrite, nonatomic, strong) NSString *name;//地址
@property (readwrite, nonatomic, strong) NSString *pinyinFull;//全拼
@property (readwrite, nonatomic, strong) NSString *pinyin;//简拼
@property (readwrite, nonatomic, strong) NSString *createTime;//创建时间
@property (readwrite, nonatomic, assign) NSInteger updateTime;//更新时间

- (id)init;
+ (City *)shareInstance;
- (City *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(City *)object;

@end


@interface ZuFangListCollection : OObject {
}
@property (readwrite, nonatomic, assign) NSInteger ret;// 状态码，0表示成功，非0表示失败
@property (readwrite, nonatomic, strong) NSMutableArray *dataList;//城市列表

- (id)init;
+ (ZuFangListCollection *)shareInstance;
- (ZuFangListCollection *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(ZuFangListCollection *)object;

@end


@interface House : OObject {
}
@property (readwrite, nonatomic, assign) NSInteger houseZufangDataId;// 房号ID
@property (readwrite, nonatomic, strong) NSString *name;//名称
@property (readwrite, nonatomic, strong) NSString *community;//小区
@property (readwrite, nonatomic, strong) NSString *position;//位置
@property (readwrite, nonatomic, assign) NSInteger floor;// 楼层
@property (readwrite, nonatomic, assign) NSInteger totalFloor;//总楼层
@property (readwrite, nonatomic, assign) CGFloat area;//面积
@property (readwrite, nonatomic, strong) NSMutableArray *houseAllocationList;//房屋配置（是一个数组）
@property (readwrite, nonatomic, assign) CGFloat rent;//租金
@property (readwrite, nonatomic, strong) NSString *contact;//联系人
@property (readwrite, nonatomic, strong) NSString *phone;//联系电话
@property (readwrite, nonatomic, strong) NSString *refreshTime;//刷新时间
@property (readwrite, nonatomic, strong) SysPositionCity *sysPositionCity;//城市ID
@property (readwrite, nonatomic, strong) SysPositionArea *sysPositionArea;//区域ID
@property (readwrite, nonatomic, strong) SysPositionCommercialArea *sysPositionCommercialArea;//商圈ID
@property (readwrite, nonatomic, strong) HouseZufangImgFront *houseZufangImgFront;//商圈ID
@property (readwrite, nonatomic, strong) NSString *houseZufangBathroom;//卫
@property (readwrite, nonatomic, strong) NSString *houseZufangBedroom;//室
@property (readwrite, nonatomic, strong) HouseZufangContactRole *houseZufangContactRole;//联系人类型
@property (readwrite, nonatomic, strong) NSString *houseZufangDepositMethod;//押金方式
@property (readwrite, nonatomic, strong) HouseZufangHall *houseZufangHall;//厅
@property (readwrite, nonatomic, strong) HouseZufangHouseType *houseZufangHouseType;//房屋类型
@property (readwrite, nonatomic, strong) NSString *houseZufangOrientation;//朝向
@property (readwrite, nonatomic, strong) HouseZufangPriceRange *houseZufangPriceRange;//价格区间
@property (readwrite, nonatomic, strong) HouseZufangRenovation *houseZufangRenovation;//装修情况
@property (readwrite, nonatomic, strong) HouseZufangRentModel *houseZufangRentModel;//出租方式
@property (readwrite, nonatomic, strong) NSString *houseZufangRentRoom;//出租间
@property (readwrite, nonatomic, strong) NSString *houseZufangTenantRequest;//租客要求

- (id)init;
+ (House *)shareInstance;
- (House *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(House *)object;

@end


@interface HouseDetail : OObject {
}
@property (readwrite, nonatomic, assign) NSInteger houseZufangDataId;// 房号ID
@property (readwrite, nonatomic, strong) NSString *name;//名称
@property (readwrite, nonatomic, strong) NSString *community;//小区
@property (readwrite, nonatomic, strong) NSString *position;//位置
@property (readwrite, nonatomic, strong) NSString *title;//标题
@property (readwrite, nonatomic, strong) NSString *description;//描述
@property (readwrite, nonatomic, strong) NSString *keywords;//描述
@property (readwrite, nonatomic, assign) NSInteger floor;// 楼层
@property (readwrite, nonatomic, assign) NSInteger totalFloor;//总楼层
@property (readwrite, nonatomic, assign) CGFloat area;//面积
@property (readwrite, nonatomic, strong) NSMutableArray *houseAllocationList;//房屋配置（是一个数组）
@property (readwrite, nonatomic, assign) CGFloat rent;//租金
@property (readwrite, nonatomic, strong) NSString *contact;//联系人
@property (readwrite, nonatomic, strong) NSString *phone;//联系电话
@property (readwrite, nonatomic, strong) NSString *details;//详情
@property (readwrite, nonatomic, strong) NSString *viewTimes;//
@property (readwrite, nonatomic, strong) NSString *refreshTime;//刷新时间
@property (readwrite, nonatomic, strong) NSString *createTime;//创建时间
@property (readwrite, nonatomic, strong) NSString *updateTime;//更新时间
@property (readwrite, nonatomic, strong) NSMutableArray *houseZufangImgDetailsList;//
@property (readwrite, nonatomic, strong) SysPositionCity *sysPositionCity;//城市ID
@property (readwrite, nonatomic, strong) SysPositionArea *sysPositionArea;//区域ID
@property (readwrite, nonatomic, strong) SysPositionCommercialArea *sysPositionCommercialArea;//商圈ID
@property (readwrite, nonatomic, strong) HouseZufangImgFront *houseZufangImgFront;//商圈ID
@property (readwrite, nonatomic, strong) NSString *houseZufangBathroom;//卫
@property (readwrite, nonatomic, strong) NSString *houseZufangBedroom;//室
@property (readwrite, nonatomic, strong) HouseZufangContactRole *houseZufangContactRole;//联系人类型
@property (readwrite, nonatomic, strong) NSString *houseZufangDepositMethod;//押金方式
@property (readwrite, nonatomic, strong) HouseZufangHall *houseZufangHall;//厅
@property (readwrite, nonatomic, strong) HouseZufangHouseType *houseZufangHouseType;//房屋类型
@property (readwrite, nonatomic, strong) NSString *houseZufangOrientation;//朝向
@property (readwrite, nonatomic, strong) HouseZufangPriceRange *houseZufangPriceRange;//价格区间
@property (readwrite, nonatomic, strong) HouseZufangRenovation *houseZufangRenovation;//装修情况
@property (readwrite, nonatomic, strong) HouseZufangRentModel *houseZufangRentModel;//出租方式
@property (readwrite, nonatomic, strong) NSString *houseZufangRentRoom;//出租间
@property (readwrite, nonatomic, strong) NSString *houseZufangTenantRequest;//租客要求

- (id)init;
+ (HouseDetail *)shareInstance;
- (HouseDetail *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseDetail *)object;

@end


@interface SysPositionCity : OObject {
}
@property (readwrite, nonatomic, strong) NSString *sysPositionCityId;//城市ID
@property (readwrite, nonatomic, strong) NSString *name;//名字
@property (readwrite, nonatomic, strong) NSString *sysPositionProvinceId;//省份的id

- (id)init;
+ (SysPositionCity *)shareInstance;
- (SysPositionCity *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(SysPositionCity *)object;

@end


@interface SysPositionArea : OObject {
}
@property (readwrite, nonatomic, strong) NSString *sysPositionAreaId;//区域ID
@property (readwrite, nonatomic, strong) NSString *name;//名字
@property (readwrite, nonatomic, strong) NSString *sysPositionCityId;//城市的id

- (id)init;
+ (SysPositionArea *)shareInstance;
- (SysPositionArea *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(SysPositionArea *)object;

@end


@interface SysPositionCommercialArea : OObject {
}
@property (readwrite, nonatomic, strong) NSString *sysPositionCommercialAreaId;//商圈ID
@property (readwrite, nonatomic, strong) NSString *name;//名字
@property (readwrite, nonatomic, strong) NSString *sysPositionAreaId;//商圈id

- (id)init;
+ (SysPositionCommercialArea *)shareInstance;
- (SysPositionCommercialArea *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(SysPositionCommercialArea *)object;

@end


@interface HouseZufangImgFront : OObject {
}
@property (readwrite, nonatomic, strong) NSString *houseZufangImgFrontId;//
@property (readwrite, nonatomic, strong) NSString *url;//
@property (readwrite, nonatomic, strong) NSString *alt;//

- (id)init;
+ (HouseZufangImgFront *)shareInstance;
- (HouseZufangImgFront *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseZufangImgFront *)object;

@end


@interface HouseZufangImgDetails : OObject {
}
@property (readwrite, nonatomic, strong) NSString *houseZufangImgDetailId;//
@property (readwrite, nonatomic, strong) NSString *url;//
@property (readwrite, nonatomic, strong) NSString *alt;//

- (id)init;
+ (HouseZufangImgDetails *)shareInstance;
- (HouseZufangImgDetails *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseZufangImgDetails *)object;

@end


@interface HouseZufangContactRole : OObject {
}
@property (readwrite, nonatomic, strong) NSString *houseZufangContactRoleId;//
@property (readwrite, nonatomic, strong) NSString *name;//
@property (readwrite, nonatomic, strong) NSString *houseZufangDicTypeId;//

- (id)init;
+ (HouseZufangContactRole *)shareInstance;
- (HouseZufangContactRole *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseZufangContactRole *)object;

@end


@interface HouseZufangHall : OObject {
}
@property (readwrite, nonatomic, strong) NSString *houseZufangHallId;//
@property (readwrite, nonatomic, strong) NSString *name;//
@property (readwrite, nonatomic, strong) NSString *houseZufangDicTypeId;//

- (id)init;
+ (HouseZufangHall *)shareInstance;
- (HouseZufangHall *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseZufangHall *)object;

@end


@interface HouseZufangHouseType : OObject {
}
@property (readwrite, nonatomic, strong) NSString *houseZufangHouseTypeId;//
@property (readwrite, nonatomic, strong) NSString *name;//
@property (readwrite, nonatomic, strong) NSString *houseZufangDicTypeId;//

- (id)init;
+ (HouseZufangHouseType *)shareInstance;
- (HouseZufangHouseType *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseZufangHouseType *)object;

@end


@interface HouseZufangPriceRange : OObject {
}
@property (readwrite, nonatomic, strong) NSString *houseZufangPriceRangeId;//
@property (readwrite, nonatomic, strong) NSString *name;//
@property (readwrite, nonatomic, strong) NSString *houseZufangDicTypeId;//

- (id)init;
+ (HouseZufangPriceRange *)shareInstance;
- (HouseZufangPriceRange *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseZufangPriceRange *)object;

@end


@interface HouseZufangRenovation : OObject {
}
@property (readwrite, nonatomic, strong) NSString *houseZufangRenovationId;//
@property (readwrite, nonatomic, strong) NSString *name;//
@property (readwrite, nonatomic, strong) NSString *houseZufangDicTypeId;//

- (id)init;
+ (HouseZufangRenovation *)shareInstance;
- (HouseZufangRenovation *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseZufangRenovation *)object;

@end


@interface HouseZufangRentModel : OObject {
}
@property (readwrite, nonatomic, strong) NSString *houseZufangRentModelId;//
@property (readwrite, nonatomic, strong) NSString *name;//
@property (readwrite, nonatomic, strong) NSString *houseZufangDicTypeId;//

- (id)init;
+ (HouseZufangRentModel *)shareInstance;
- (HouseZufangRentModel *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(HouseZufangRentModel *)object;

@end


@interface ZufangDetailsCollection : OObject {
}
@property (readwrite, nonatomic, assign) NSInteger ret;// 状态码，0表示成功，非0表示失败
@property (readwrite, nonatomic, strong) NSMutableArray *dataList;//城市列表

- (id)init;
+ (ZufangDetailsCollection *)shareInstance;
- (ZufangDetailsCollection *)parseFromDictionary:(NSDictionary *)sender;
- (NSMutableDictionary *)dictionaryValue;
- (void)copyOperationWithObject:(ZufangDetailsCollection *)object;

@end
