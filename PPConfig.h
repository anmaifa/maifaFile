//
// PPConfig.h 
//
// Created By 安美发 Version: 2.0
// Copyright (C) 2017/08/05  By meifaan  All rights reserved.
// email:// 917524965@qq.com  tel:// +86 13682465601 
//
//

/**
 *    @brief	DEBUG模式的输出
 */
#if !defined(DEBUG) || DEBUG == 0
#define CCLOG(...) do {} while (0)
#define CCLOGINFO(...) do {} while (0)
#define CCLOGERROR(...) do {} while (0)
#define XXLOG do {} while (0)

#elif DEBUG >= 1
#define CCLOG(...) NSLog(__VA_ARGS__)
#define CCLOGERROR(...) NSLog(__VA_ARGS__)
#define CCLOGINFO(...) do {} while (0)
#define XXLOG NSLog(@"-->> <<%@>> -->> <<%@>> ", self.class, NSStringFromSelector(_cmd));

#endif // DEBUG


#define HOST_NAME @"http://123.207.237.172"
#define BASE_URL @""
#define City_list @"/position/city"
#define Zufang_list @"/house/zufang"
#define Zufang_Detail @"/house/zufang/details"
