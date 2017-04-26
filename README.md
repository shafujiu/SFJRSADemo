# SFJRSADemo
RSA DES加解密

### RSA

RSA 加解密是来自于大神的封装 [HustBroventure/iOSRSAHandler](https://github.com/HustBroventure/iOSRSAHandler)
由于openssl的导入相对比较麻烦，文件也比较多，所以该Demo将RSA 加解密基于HustBroventure/iOSRSAHandler
制作了一个静态库 使用的时候只需将在项目中引入`RSASDK` 文件件即可。

提供的方法如下,相信这方法名已经足以表达该方法的用处了，所以未作过多的注释
```Objective-c
- (BOOL)importKeyWithType:(KeyType)type andPath:(NSString*)path;
- (BOOL)importKeyWithType:(KeyType)type andkeyString:(NSString *)keyString;

    //验证签名 Sha1 + RSA
- (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString;
    //验证签名 md5 + RSA
- (BOOL)verifyMD5String:(NSString *)string withSign:(NSString *)signString;

- (NSString *)signString:(NSString *)string;

- (NSString *)signMD5String:(NSString *)string;

- (NSString *) encryptWithPublicKey:(NSString*)content;
- (NSString *) decryptWithPrivatecKey:(NSString*)content;
```

然后在ViewController里面有 RSA的用法

### DES

DES 加解密 算法不是特别精准，在实现文件里面还作了相应调整，所以并没有打包静态库。

>加密：
>1. 将需要加密的文字，通过UTF8编码转为Data
>2. 通过系统的CCCrypt（）函数，将提供的密码与文字 进行编码
>3. 取出缓存内的数据，再通过base64 转为文字 

>解密：
>1. 将密文，通过base64解码为NSData
>2. 同样是通过系统CCCrypt()函数（通常适配android 与 iOS两端的话，对密文的对齐方式是需要统一的需要设置成kCCOptionPKCS7Padding|kCCOptionECBMode）
>3. 取出缓存中的Data 通过UTF8 解码 输出文字。

大致流程是这样详细实现请参考Demo中DESEncrypt.m 文件

DES 提供了2个方法，分别是 加密，解密的。具体使用请参考demo
```Objective-c
//加密方法
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密方法
+(NSString *) decryptUseDES:(NSString *)cipherText key:(NSString *)key;
```


