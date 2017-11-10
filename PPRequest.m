//
// PPRequest.m 
//
// Created By 安美发 Version: 2.0
// Copyright (C) 2017/08/26  By AnMeiFa  All rights reserved.
// email:// 917524965@qq.com  tel:// +86 13682465601 
//
//

#import "PPRequest.h"

@implementation PPRequest

+ (instancetype _Nonnull)sharedClient {
	static PPRequest *_sharedClient;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{ 
		_sharedClient = [[PPRequest alloc] initWithBaseURL:[NSURL URLWithString:HOST_NAME]];
		_sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
		_sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
		_sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];//如果报接受类型不一致请替换一致text/html或别的
		_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];//申明请求的数据是json类型
	});
	return _sharedClient;
}


/**
 * @brief 
 **/
+(NSURLSessionDataTask * _Nonnull)positioncityRequestUrl:(NSString * _Nullable)baseurl success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, CityCollection * _Nullable result))success  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;{
	[SVProgressHUD showProgress:0];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	NSURLSessionDataTask *op = [[PPRequest sharedClient] GET:[NSString stringWithFormat:@"%@%@", BASE_URL, baseurl] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
		[SVProgressHUD showProgress:((CGFloat)uploadProgress.completedUnitCount)/((CGFloat)uploadProgress.totalUnitCount)];
	} success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable result) {
		[SVProgressHUD dismiss];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		CityCollection *info;
		info = [CityCollection parseFromDictionary:result];
		success(task, info);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[WToast showWithText:@"网络异常"];
		[SVProgressHUD dismiss];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		failure(task, error);
	}];
	return op;
}


/**
 * @brief 
 * @prama sysPositionCityId: 城市ID
 **/
+(NSURLSessionDataTask * _Nonnull)zufangListRequestUrl:(NSString * _Nullable)baseurl sysPositionCityId:(NSInteger)sysPositionCityId success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, ZuFangListCollection * _Nullable result))success  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;{
	[SVProgressHUD showProgress:0];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setObj:[NSNumber numberWithInteger:sysPositionCityId] forKey:@"sysPositionCityId"];
	NSURLSessionDataTask *op = [[PPRequest sharedClient] GET:[NSString stringWithFormat:@"%@%@", BASE_URL, baseurl] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
		[SVProgressHUD showProgress:((CGFloat)uploadProgress.completedUnitCount)/((CGFloat)uploadProgress.totalUnitCount)];
	} success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable result) {
		[SVProgressHUD dismiss];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		ZuFangListCollection *info;
		info = [ZuFangListCollection parseFromDictionary:result];
		success(task, info);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[WToast showWithText:@"网络异常"];
		[SVProgressHUD dismiss];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		failure(task, error);
	}];
	return op;
}


/**
 * @brief 
 * @prama houseZufangDataId: 租房ID
 **/
+(NSURLSessionDataTask * _Nonnull)zufangDetailsRequestUrl:(NSString * _Nullable)baseurl houseZufangDataId:(NSInteger)houseZufangDataId success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, ZufangDetailsCollection * _Nullable result))success  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;{
	[SVProgressHUD showProgress:0];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setObj:[NSNumber numberWithInteger:houseZufangDataId] forKey:@"houseZufangDataId"];
	NSURLSessionDataTask *op = [[PPRequest sharedClient] GET:[NSString stringWithFormat:@"%@%@", BASE_URL, baseurl] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
		[SVProgressHUD showProgress:((CGFloat)uploadProgress.completedUnitCount)/((CGFloat)uploadProgress.totalUnitCount)];
	} success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable result) {
		[SVProgressHUD dismiss];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		ZufangDetailsCollection *info;
		info = [ZufangDetailsCollection parseFromDictionary:result];
		success(task, info);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[WToast showWithText:@"网络异常"];
		[SVProgressHUD dismiss];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		failure(task, error);
	}];
	return op;
}



@end


