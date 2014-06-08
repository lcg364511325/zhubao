//
//  customer.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface customer : NSObject

@property (nonatomic, retain) NSString * uId;
@property (nonatomic, retain) NSString * userType;//用户类别	0 个人用户, 1 企业用户
@property (nonatomic, retain) NSString * userName;//昵称
@property (nonatomic, retain) NSString * userPass;//密码 新加的密码要已加密码32位md5(可以调此方法加密[Commons md5:[NSString stringWithFormat:@"%@",@"明文密码"]];)
@property (nonatomic, retain) NSString * userDueDate;//到期日期	预留 没有为空
@property (nonatomic, retain) NSString * userTrueName;//真实姓名/企业名称
@property (nonatomic, retain) NSString * sfUrl;//个人身份证扫描件图片地址
@property (nonatomic, retain) NSString * lxrName;//企业联系人姓名
@property (nonatomic, retain) NSString * Sex;//企业联系人性别/个人用户性别	0-女，-男
@property (nonatomic, retain) NSString * bmName;//企业联系人所在部门	1-办公室，2-市场部，3-采购部，4-技术部，5-人力资源，6-其他
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) NSString * Phone;//企业联系人电话，个人用户手机号
@property (nonatomic, retain) NSString * Lxphone;//企业联系人手机号
@property (nonatomic, retain) NSString * Sf;//省份
@property (nonatomic, retain) NSString * Cs;//城市
@property (nonatomic, retain) NSString * Address;//详细街道地址

@property (nonatomic, retain) NSString * oldpassword;//旧的密码 //已加密码32位md5

@end
