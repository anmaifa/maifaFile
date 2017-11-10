//
// PPRequest.h 
//
// Created By 安美发 Version: 2.0
// Copyright (C) 2017/08/26  By AnMeiFa  All rights reserved.
// email:// 917524965@qq.com  tel:// +86 13682465601 
//
//

#import <AFNetworking/AFNetworking.h>
#import <WToast/WToast.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "PPConfig.h"
#import "PPModel.h"


@interface PPRequest : AFHTTPSessionManager {
}

+ (instancetype _Nonnull)sharedClient;


/**
 * @brief 
 **/
+(NSURLSessionDataTask * _Nonnull)positioncityRequestUrl:(NSString * _Nullable)baseurl success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, CityCollection * _Nullable result))success  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;

/**
 * @brief 
 * @prama sysPositionCityId: 城市ID
 **/
+(NSURLSessionDataTask * _Nonnull)zufangListRequestUrl:(NSString * _Nullable)baseurl sysPositionCityId:(NSInteger)sysPositionCityId success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, ZuFangListCollection * _Nullable result))success  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;

/**
 * @brief 
 * @prama houseZufangDataId: 租房ID
 **/
+(NSURLSessionDataTask * _Nonnull)zufangDetailsRequestUrl:(NSString * _Nullable)baseurl houseZufangDataId:(NSInteger)houseZufangDataId success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, ZufangDetailsCollection * _Nullable result))success  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;


@end


