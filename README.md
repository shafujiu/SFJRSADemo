# SFJRSADemo
RSA DES加解密

### RSA

RSA 加解密是来自于大神的封装 [HustBroventure/iOSRSAHandler](https://github.com/HustBroventure/iOSRSAHandler)
由于openssl的导入相对比较麻烦，文件也比较多，所以该Demo将RSA 加解密基于HustBroventure/iOSRSAHandler
制作了一个静态库 使用的时候只需将在项目中引入`RSASDK` 文件件即可。

#### 生RSA密钥

- 生成RSA私钥
`openssl genrsa -out rsa_private_key.pem 1024`
注意生成的路径，如果需要在指定路径下拿到该文件，那么需要cd到该路径下。

- 生成RSA公钥
`openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem`
注意通常iOS 与 android都是同步开发的，但是这里的私钥的格式与android是不一样的，需要将私钥转换成PKCS8格式
- 转换为pkcs8格式
`openssl pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt -out private_key.pem`
（后边一定要加-out private_key.pem将转换后的私钥保存在private_key.pem，不然得到的结果要设置密码且显示在终端中，这个和得到pem中的私钥有差异。）


#### 方法介绍
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

#### RSA 中 openssl库，对bitcode的支持

之前的版本oppenssl库对bitcode是不支持的，所以当我们用真机调试的时候就会报错。那么如何让我们的libHBRSAHandlerLib.a静态库也支持bitcode呢。

这其实是两个问题

1. openssl支持bitcode
2. libHBRSAHandlerLib.a支持bitcode

解决问题2的关键就是解决问题1。通常也就这一种方式。静态库中只要你引用的任何一个第三方静态库不支持bitcode那么你最后打包的静态库 也是不能支持bitcode的。

那么我们要做的就是解决问题一，然后再用支持bitcode的openssl库去制作我们能的静态库这样就解决了。

#### 编译支持bitcode的openssl库

参考 [iOS编译OpenSSL静态库(使用脚本自动编译)](http://www.jianshu.com/p/651513cab181)
使用开源的脚本来自动编译，我们需要的openssl库。

最后这里是libHBRSAHandlerLib.a的制作的demo的github地址
[HBRSAHandlerLib](https://github.com/shafujiu/HBRSAHandlerLib)



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


