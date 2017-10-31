//
//  XXUtils.h
//  XPHFramework
//
//  Created by Shanke on 14-3-6.
//  Copyright (c) 2014年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BaseHeader.h"

@interface PPUtils : NSObject


#pragma mark -- 获取系统版本号
float OSVersion();

#pragma mark -- 判断设备是否是iPad
BOOL DeviceIsiPad();

#pragma mark -- 验证邮箱的有效性
BOOL CheckEmail(NSString *sender);

#pragma mark -- 验证字符串的有效性
BOOL CheckString(NSString *sender);

#pragma mark -- 验证手机号的有效性
BOOL CheckTelNumber(NSString *sender);

#pragma mark -- 正则匹配用户密码6-18位数字和字母组合
BOOL CheckPassword(NSString *sender) ;

#pragma mark --  正则匹配用户姓名,20位的中文或英文
BOOL CheckUserName(NSString *sender) ;

#pragma mark -- 正则匹配用户身份证号15或18位
BOOL CheckUserIdCard(NSString *sender) ;

#pragma mark -- 正则匹员工号,12位的数字
BOOL CheckEmployeeNumber(NSString *sender);

#pragma mark -- 正则匹配URL
BOOL CheckURL(NSString *sender);

#pragma mark -- 16进制颜色值转化为颜色 #FF555511
UIColor *ColorWithHexString(NSString *sender);

#pragma mark -- 字符串MD5 加密
NSString *MD5(NSString *sender);

#pragma mark -- 按钮添加倒计时效果
BOOL StartTime(UIButton *sender);

#pragma mark -- 生成随机码 isCode 表示是否是纯数字
NSString *MakeCode(BOOL isCode);

#pragma mark -- 创建纯色的图片
UIImage *CreateImageWithColor(UIColor *sender);

#pragma mark -- 网络请求的基本参数
NSDictionary *BaseParams(NSString *sender);

#pragma mark -- 根据视频URL 生成缩略图
UIImage *ThumbnailImageForVideo(NSURL *videoURL, NSTimeInterval time);

#pragma mark -- 提示信息
void ShowTips(NSString *tips);

#pragma mark -- 获取当前vc
UIViewController *CurrentVC();



@end
