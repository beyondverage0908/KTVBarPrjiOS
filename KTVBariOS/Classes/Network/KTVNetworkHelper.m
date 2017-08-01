//
//  KTVNetworkHelper.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVNetworkHelper.h"
#import "AFNetworking.h"

@interface KTVNetworkHelper ()

@property(nonatomic, strong) AFHTTPSessionManager *manager;

@end

// 加密开关
//static BOOL Switch_Encrypted_Is_Open = YES;
//连接超时秒
double const CONNECT_TIMEOUT = 10;
static KTVNetworkHelper *_instance = nil;

@implementation KTVNetworkHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[KTVNetworkHelper alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    @synchronized (self) {
        if (self = [super init]) {
            _manager = [AFHTTPSessionManager manager];
            _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
            _manager.securityPolicy.allowInvalidCertificates = YES;
            [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            _manager.requestSerializer.timeoutInterval = CONNECT_TIMEOUT;
            [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            // 安全验证 - reference : http://www.jianshu.com/p/f732749ce786
            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode: AFSSLPinningModeCertificate];
            NSString *certificatePath = [[NSBundle mainBundle] pathForResource:@"vplus_https" ofType:@"cer"];
            NSData *certificateData = [NSData dataWithContentsOfFile:certificatePath];
            
            NSSet *certificateSet  = [[NSSet alloc] initWithObjects:certificateData, nil];
            [securityPolicy setPinnedCertificates:certificateSet];
            securityPolicy.allowInvalidCertificates = YES;
            securityPolicy.validatesDomainName = NO;
            _manager.securityPolicy = securityPolicy;
        }
    }
    return self;
}

#pragma mark - Get, Post, Upload Request Method

- (void)getRequestWithResquestMessage:(KTVRequestMessage *)message success:(RequestSuccess)success failure:(RequestFailure)failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:message.params];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", KTV_BASE_URL, message.path];
    CLog(@"URL %@", urlString);
    
    [_manager GET:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // 解密服务器返回值
        NSDictionary *result = [self sessionWithNetResponse:responseObject message:message];
        
        if (success) {
            success(result); //成功回调
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void)postRequestWithResquestMessage:(KTVRequestMessage *)message success:(RequestSuccess)success failure:(RequestFailure)failure {

    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:message.params];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", KTV_BASE_URL, message.path];
    CLog(@"URL %@", urlString);
    
    [_manager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // 解密服务器返回值
        NSDictionary *result = [self sessionWithNetResponse:responseObject message:message];
        
        if (success) success(result); //成功回调
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
        if (failure) {
            failure(error);
        }
    }];
}

// 流的形式上传头像
- (void)uploadRequestWithResquestMessage:(KTVRequestMessage *)message success:(RequestSuccess)success failure:(RequestFailure)failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", KTV_BASE_URL, message.path];
    
    //2.上传文字时用到的拼接请求参数(如果只传图片，可不要此段）
    //NSMutableDictionary *params = [NSMutableDictionary dictionary];//创建一个名为params的可变字典
    //params[@"status"] = self.textView.text;//通过服务器给定的Key上传数据
    
    //3.发送请求
    [_manager POST:urlString parameters:message.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        /*
         Data: 要上传的二进制数据
         name:保存在服务器上时用的Key值
         fileName:保存在服务器上时用的文件名,注意要加 .jpg或者.png
         mimeType:让服务器知道我上传的是哪种类型的文件
         */
        
        //多张图片
        for(NSInteger i = 0; i < [message.imageMap.allKeys count]; i++) {
            // 图片的key
            NSString *imageKey = [message.imageMap.allKeys objectAtIndex:i];
            // 取出图片
            UIImage *image = message.imageMap[imageKey];
            // 转成二进制
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            // 上传的参数名
            NSString *name = [NSString stringWithFormat:@"%@", imageKey];
            // 上传fileName
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", name];
            
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
        // 解密服务器返回值
        NSDictionary *result = [self sessionWithNetResponse:response message:message];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (success) success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (failure) failure(error);
    }];
}

- (void)sendMessage:(KTVRequestMessage*)message success:(RequestSuccess)successBlock fail:(RequestFailure)failBlock {
    
    if (![KTVUtil isNetworkAvailable]) {
        [KTVToast toast:TOAST_NO_NETWORK];
        return;
    }
    
    _manager.requestSerializer.timeoutInterval = message.timeout ? message.timeout : CONNECT_TIMEOUT;
    
    // 设置http的头部
    [self setHttpHeaderFieldWithMessage:message];
    // 对数据包body，params加密
    [self encryptedMessage:message];
    
    // 正式版本
    if (message.httpType == KtvPOST) {
        [self postRequestWithResquestMessage:message success:successBlock failure:failBlock];
    } else if (message.httpType == KtvUpload) {
        [self uploadRequestWithResquestMessage:message success:successBlock failure:failBlock];
    } else {
        [self getRequestWithResquestMessage:message success:successBlock failure:failBlock];
    }
}

- (void)setHttpHeaderFieldWithMessage:(KTVRequestMessage *)message {
//    if (![VHSCommon isNullString:[VHSCommon vhstoken]]) {
//        [_manager.requestSerializer setValue:[VHSCommon vhstoken] forHTTPHeaderField:@"vhstoken"];
//    } else {
//        [_manager.requestSerializer setValue:@"" forHTTPHeaderField:@"vhstoken"];
//    }
//    
//    [_manager.requestSerializer setValue:[VHSCommon deviceToken] forHTTPHeaderField:@"imei"];
//    [_manager.requestSerializer setValue:[VHSCommon osVersion] forHTTPHeaderField:@"osversion"];
//    [_manager.requestSerializer setValue:[VHSCommon appVersion] forHTTPHeaderField:@"appversion"];
//    [_manager.requestSerializer setValue:[VHSCommon phoneModel] forHTTPHeaderField:@"model"];
//    
//    if (message.httpMethod != VHSNetworkUpload && Switch_Encrypted_Is_Open) {
//        [_manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"encrypt"];
//    }
//    
//    CLog(@"vhstoken = %@", [VHSCommon vhstoken]);
}

#pragma mark - 加密和解密服务器数据

/// 加密传输给服务器的数据
- (void)encryptedMessage:(KTVRequestMessage *)message {
//    if (!Switch_Encrypted_Is_Open) return;
//    
//    NSString *aesKey = [VHSUtils generateRandomStr16];
//    message.aesKey = aesKey;
//    
//    VHSSecurityUtil *security = [VHSSecurityUtil share];
//    if (!message.params || ![[message.params allKeys] count]) {
//        message.params = @{@"key" : [security rsaGenerateKeyOfRandomStr16WithKey:aesKey]};
//    } else {
//        message.params = [security encryptWithRandomKey:aesKey data:message.params sign:message.sign];
//    }
}

/// 解密服务器返回的加密数据
- (NSDictionary *)sessionWithNetResponse:(NSDictionary *)netResponse message:(KTVRequestMessage *)message {
//    if (!Switch_Encrypted_Is_Open) return netResponse;
//    
//    // 解密服务器返回值
//    NSString *sessionStream = netResponse[@"data"];
//    NSString *response = [[VHSSecurityUtil share] aesDecryptStr:sessionStream pwd:message.aesKey];
//    NSDictionary *result = [response convertObject];
    
    return netResponse;
}

@end
