
//
//  Request.m
//  QuickPos
//
//  Created by 糊涂 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "Request.h"



//#import "QuickPos.h"

//#import "QuickPosTabBarController.h"
//#import "SystemPrivacySDK.h"
////#import "JSONKit.h"
//#import "GTMBase64.h"





#define SHOPSUOYUAN_BASEURL @"http://www.shfda.org/platform/rest/v2/" //商品朔源BaseUrl
#define SHOPSUOYUAN_BASEURL2 @"http://www.shfda.org/platform/rest/v1/tag/validation/" //手动商品朔源


#define TimeOut 60
@interface Request(){

    
}
@property(nonatomic, strong)NSObject<ResponseData>* delegate;
@end

@implementation Request
// 请求标识定义

- (instancetype)initWithDelegate:(NSObject<ResponseData>*)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - 商品朔源接口集

/**
 * 查询溯源企业
 */
- (void)getCompanySYwihtName:(NSString*)name fieldNames:(NSString*)fieldNames regionCity:(NSString*)regionCity pageNo:(NSString*)pageNo pageSize:(NSString*)pageSize Bool:(BOOL)yes{
    
     NSString *urlBef = @"enterprises?";
    if (yes == YES) {
        NSString *url = [NSString stringWithFormat:@"%@&name=%@&pageNo=%@&pageSize=%@",urlBef,name,pageNo,pageSize];
          [self requestWihtdictSY:url requestType:REQUSET_GETCOMPENYSY];
    }else{
          NSString *url = [NSString stringWithFormat:@"%@&pageNo=%@&pageSize=%@",urlBef,pageNo,pageSize];
          [self requestWihtdictSY:url requestType:REQUSET_GETCOMPENYSY];
    }
}

/**
 * 根据企业ID、条码或名称查询匹配的企业产品列表
 */
-(void)getCompanyListWithID:(NSString*)ID pageNo:(NSString*)pageNO pageSize:(NSString*)pagesize{
    
    NSString *urlBef = @"products?";
    NSString *url = [NSString stringWithFormat:@"%@&enterpriseId=%@&pageNo=%@&pageSize=%@",urlBef,ID,pageNO,pagesize];
    [self requestWihtdictSY:url requestType:REQUSET_products];
}
/**
 *3.4根据ID的产品查询
 */
- (void)getProductInfoWihtID:(NSString*)ID{
    NSString *urlBef = @"products/";
    NSString *url = [NSString stringWithFormat:@"%@%@",urlBef,ID];
    [self requestWihtdictSY:url requestType:REQUSET_PRODUCTINFO];
}
/**
 *3.5最近三笔三笔进货记录查询
 */
- (void)getProductInfoNearLyThreeList:(NSString*)CodeID{
    NSString *urlBef = @"accountdata/latestIn?";
    NSString *url = [NSString stringWithFormat:@"%@productId=%@",urlBef,CodeID];
    [self requestWihtdictSY:url requestType:REQUSET_ProductID];
}
/**
 *3.6追溯码的追溯查询
 */
-(void)getProductNodeListProductID:(NSString*)ID productionDate:(NSString*)date batch:(NSString*)batch{
    NSString *urlBef = @"tag/validation?";
    NSString *url = [NSString stringWithFormat:@"%@productId=%@&productionDate=%@&batch=%@",urlBef,ID,date,batch];
    [self requestWihtdictSY:url requestType:REQUSET_validation];
}



//3.2平台产品分类查询
-(void)getProductSYcategories{
    NSString *urlBef = @"categories";
    NSString *url = [NSString stringWithFormat:@"%@",urlBef];
      [self requestWihtdictSY:url requestType:REQUSET_categories];
    
}

/**7
 * 根据产品名称查产品列表
 *
 * @param product
 *            正常情况 product 和parentCategory不同时有值
 * @param pageSize
 * @param pageNo
 * @param parentCategory
 *            分类（九大类）
 * @return
 * @throws UnsupportedEncodingException
 */
// http://www.shfda.org/platform/rest/v2/products?product=&parentCategory=粮食及其制品&pageNo=1&pageSize=20
-(void)getProductSYcategoriesWithName:(NSString*)name pageNo:(NSString*)pageNo pageSIze:(NSString*)pageSize{
    NSString *urlBef = @"products?";
//    
//    NSString *utf8Str = name;
//    NSString *unicodeStr = [NSString stringWithCString:[utf8Str UTF8String] encoding:NSUnicodeStringEncoding];
     NSString *url = [NSString stringWithFormat:@"%@product=&parentCategory=%@&pageNo=%@&pageSize=%@",urlBef,name,pageNo,pageSize];
     [self requestWihtdictSY:url requestType:REQUSET_categoriesProduct];
}

-(void)requestWihtdictSY:(NSString*)url requestType:(NSInteger)payType{

    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlC = [NSString stringWithFormat:@"%@%@",SHOPSUOYUAN_BASEURL,url];
    urlC = [urlC stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manger GET:urlC parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictReq = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (dictReq && [_delegate respondsToSelector:@selector(responseWithDict:requestType:)]) {
            [self.delegate responseWithDict:dictReq requestType:payType];
            NSLog(@"tk%@",dictReq);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",task,[task class]);
        NSLog(@"%@",error);
        if (error.code == -1001) {
//            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow WithString:@"请求超时,请稍后重试"];
        }
        if (error.code == -1009) {
//            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow WithString:@"请求超时,请稍后重试"];
        }
    }];

}

//**6snCode搜索 // 这个鸟接口 真尼玛蛋疼
- (void)getProductSYInfoByScCode:(NSString*)code{
    
    NSString *url = [NSString new];
    url = @"http://www.shfda.org/platform/rest/v1/tag/validation/";
    NSString *c = [NSString stringWithFormat:@"%@%@",url,code];
    [self requestWihtdictSY2:c requestType:REQUSET_snCode];
    
}
-(void)requestWihtdictSY2:(NSString*)url requestType:(NSInteger)payType{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *dictReq = [Request dictionaryWithJsonString:aString];
        if (dictReq && [_delegate respondsToSelector:@selector(responseWithDict:requestType:)]) {
            [self.delegate responseWithDict:dictReq requestType:payType];
            NSLog(@"tk%@",dictReq);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",task,[task class]);
        NSLog(@"%@",error);
        if (error.code == -1001) {
//            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow WithString:@"请求超时,请稍后重试"];
        }
        if (error.code == -1009) {
//            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow WithString:@"请求超时,请稍后重试"];
        }
    }];
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
// 投诉接口
- (void)postComplaintWithtagId:(NSString*)tagId tagSn:(NSString*)tagSn tagSnProducerCode:(NSString*)tagSnProducerCode enterpriseId:(NSString*)enterpriseId productId:(NSString*)productId  userName:(NSString*)userName mobile:(NSString*)mobile comments:(NSString*)comments{
    
    UIImage *iamge = [UIImage imageNamed:@"22"];
    NSData *data2 = UIImageJPEGRepresentation(iamge, 0.5);
    NSString *dd = [data2 base64Encoding];
    
    
    
//    NSDictionary *dict = @{
//                           @"tagId": tagId,
//                           @"tagSn": tagSn,
//                           @"tagSnProducerCode": tagSnProducerCode,
//                           @"enterpriseId": enterpriseId,
//                           @"productId": productId,
//                           @"processId": @"",
//                           @"batch":@"" ,
//                           @"productionDate": @"",
//                           @"openId": @"",
//                           @"channel":@"",
//                           @"userName": userName,
//                           @"mobile": mobile,
//                           @"email": @"",
//                           @"comments": comments,
//                           @"address": @"",
//                           @"pictureBin": dd
//                           };
    
    
    NSDictionary *dict = @{
                           @"userName": userName,
                           @"mobile": mobile,
                           @"comments": comments
                           };
    NSString *sss = [NSString stringWithFormat:@"%@complaints",SHOPSUOYUAN_BASEURL];
    NSString *bodyString = [NSString stringWithFormat:@"%@",dict];
    NSData *bodyData = [[bodyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]dataUsingEncoding:NSUTF8StringEncoding];//把bodyString转换为NSData数据
    NSURL *serverUrl = [NSURL URLWithString:sss];//获取到服务器的url地址
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];//请求这个地址， timeoutInterval:10 设置为10s超时：请求时间超过10s会被认为连接不上，连接超时
    
    [request setHTTPMethod:@"POST"];//POST请求
    [request setHTTPBody:bodyData];//body 数据
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];//请求头
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//同步发送request，成功后会得到服务器返回的数据
    //返回的数据 根据系统的不同会返回不同编码的数据，比如windows 为GBK，Ubuntu 为UTF8.。。
    //注意转换编码格式

    NSString *sssssssss = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];

    
    
//    [self requestWithDictSYpost:dict requestType:REQUSET_Complaint withUrl:@"complaints"];
    
}
- (void)requestWithDictSYpost:(NSDictionary*)dict requestType:(NSInteger)type  withUrl:(NSString *)url{
    NSString *sss = [NSString stringWithFormat:@"%@%@",SHOPSUOYUAN_BASEURL,url];
    NSLog(@"sss== %@",sss);
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

    
    
    
}
@end
