//
//  DESEncrypt.h
//  FarmIrrigationAssistant
//
//  Created by 沙缚柩 on 2017/3/3.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESEncrypt : NSObject

//加密方法
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密方法
+(NSString *) decryptUseDES:(NSString *)cipherText key:(NSString *)key;


@end
