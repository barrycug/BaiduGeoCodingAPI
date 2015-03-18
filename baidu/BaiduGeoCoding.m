//
//  BaiduGeoCoding.m
//  Flashlight
//
//  Created by baocai on 3/17/15.
//  Copyright (c) 2015 baocai. All rights reserved.
//

#import "BaiduGeoCoding.h"
#import "AFNetworking.h"
#import "NSString+Extended.h"
@implementation BaiduGeoCodingResult

-(id)initWithJSON:(id)json
{
    id obj = nil;
    if (self = [super init]) {
        obj= [json objectForKey:@"status"];
        if (obj != nil && obj  !=[NSNull null] ) {
           self.status =  [((NSNumber *)obj) intValue];
        }
        obj= [json objectForKey:@"result"];
        if (obj != nil && obj  !=[NSNull null] ) {
            id result = obj;
            obj= [result objectForKey:@"location"];
            if (obj != nil && obj  !=[NSNull null] ) {
                double x,y;
                x =[[obj objectForKey:@"lng"] doubleValue];
                y =[[obj objectForKey:@"lat"] doubleValue];
                self.location =  [[CLLocation alloc]initWithLatitude:y longitude:x];
            }
            obj= [result objectForKey:@"precise"];
            if (obj != nil && obj  !=[NSNull null] ) {
                self.precise =  [((NSNumber *)obj) intValue];
            }
            obj= [result objectForKey:@"confidence"];
            if (obj != nil && obj  !=[NSNull null] ) {
                self.confidence =  [((NSNumber *)obj) intValue];
            }
            obj= [result objectForKey:@"level"];
            if (obj != nil && obj  !=[NSNull null] ) {
                self.level =  obj;
            }
        }
        
        
    }
    return self;
}
@end
@implementation BaiduAddrComponent
/*
 @property(nonatomic,strong)NSString * city;
 @property(nonatomic,strong)NSString * district;
 @property(nonatomic,strong)NSString * province;
 @property(nonatomic,strong)NSString * street;
 @property(nonatomic,strong)NSString * street_number;
 */
-(id)initWithJSON:(id)json
{
    if (self = [super init]) {
        id obj = nil;
        obj= [json objectForKey:@"city"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.city =  obj;
        }
        obj= [json objectForKey:@"district"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.district =  obj;
        }
        obj= [json objectForKey:@"province"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.province =  obj;
        }
        obj= [json objectForKey:@"street"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.street =  obj;
        }
        obj= [json objectForKey:@"street_number"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.street_number =  obj;
        }
    }
    return self;
}
@end
@implementation BaiduPOI
-(id)initWithJSON:(id)json
{
    if (self = [super init]) {
        id obj = nil;
        obj= [json objectForKey:@"addr"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.addr =  obj;
        }
        obj= [json objectForKey:@"cp"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.cp =  obj;
        }
        obj= [json objectForKey:@"distance"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.distance =   [((NSNumber *)obj) doubleValue];
        }
        obj= [json objectForKey:@"name"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.name =  obj;
        }
        obj= [json objectForKey:@"poiType"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.poiType =  obj;
        }
        
        obj= [json objectForKey:@"point"];
        if (obj != nil && obj  !=[NSNull null] ) {
            double x,y;
            x =[[obj objectForKey:@"x"] doubleValue];
            y =[[obj objectForKey:@"y"] doubleValue];
            self.point =  [[CLLocation alloc]initWithLatitude:y longitude:x];
        }
        obj= [json objectForKey:@"tel"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.tel =   obj;
        }
        obj= [json objectForKey:@"uid"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.uid =  obj;
        }
        obj= [json objectForKey:@"zip"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.zip =  obj;
        }
    }
    return self;
}
@end
@implementation BaiduReverseGeoCodingResult
-(id)initWithJSON:(id)json
{
    if (self = [super init]) {
        id obj = nil;
        obj= [json objectForKey:@"status"];
        if (obj != nil && obj  !=[NSNull null] ) {
            self.status =  [((NSNumber *)obj) intValue];
        }
        obj= [json objectForKey:@"result"];
        if (obj != nil && obj  !=[NSNull null] ) {
            id result = obj;
            obj= [result objectForKey:@"location"];
            if (obj != nil && obj  !=[NSNull null] ) {
                double x,y;
                x =[[obj objectForKey:@"lng"] doubleValue];
                y =[[obj objectForKey:@"lat"] doubleValue];
                self.location =  [[CLLocation alloc]initWithLatitude:y longitude:x];
            }
            obj= [result objectForKey:@"formatted_address"];
            if (obj != nil && obj  !=[NSNull null] ) {
                self.formatted_address =  obj;
            }
            obj= [result objectForKey:@"business"];
            if (obj != nil && obj  !=[NSNull null] ) {
                self.business =  obj;
            }
            obj= [result objectForKey:@"addressComponent"];
            if (obj != nil && obj  !=[NSNull null] ) {
                self.addrComponent =  [[BaiduAddrComponent alloc]initWithJSON:obj];
            }
            obj= [result objectForKey:@"pois"];
            if (obj != nil && obj  !=[NSNull null] ) {
                if ([obj isKindOfClass:[NSArray class]]) {
                    NSMutableArray * iPois = [NSMutableArray new];
                    for (id arr in obj) {
                        BaiduPOI * poi = [[BaiduPOI alloc]initWithJSON:arr];
                        [iPois addObject:poi];
                    }
                    self.pois =iPois;
                }
            }

        }
    }
    return self;
}
@end

@interface BaiduGeoCoding()
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * key;

@end

@implementation BaiduGeoCoding
-(id)initWithKey:(NSString*)key
{
    return [self initWithUrl:@"http://api.map.baidu.com/geocoder/v2/" andKey:key];
}
-(id)initWithUrl:(NSString*)url andKey:(NSString*)key
{
    if (self = [super init]) {
        self.url = url;
        self.key = key;
    }
    return self;
}
-(void)geocoding:(NSString*)address city:(NSString*)city result:(void (^)(BaiduGeoCodingResult * result,NSError * error))callback
{
    NSString * urlString = [self buildGeocodingHttpUrl:address city:city];
    NSURL *url = [NSURL URLWithString:[urlString urlencode]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaiduGeoCodingResult * geoCodingResult = [[BaiduGeoCodingResult alloc]initWithJSON:responseObject];
        if (callback) {
            callback(geoCodingResult,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(nil,error);
        }
        
    }];
    [operation start];
}
-(NSString*)buildGeocodingHttpUrl:(NSString*)address city:(NSString*)city
{
    NSString * url = nil;
    if (city != nil) {
       url  = [NSString stringWithFormat:@"%@?ak=%@&address=%@&city=%@&output=json",self.url,self.key,address,city];
    }
    else
    {
        url  = [NSString stringWithFormat:@"%@?ak=%@&address=%@&output=json",self.url,self.key,address];
    }
    
    return url;
}
-(NSString*)buildReverseGeocodingHttpUrl:(CLLocation*)location
{
    NSString * url = [NSString stringWithFormat:@"%@?ak=%@&location=%lf,%lf&output=json&pois=1",self.url,self.key,location.coordinate.latitude,location.coordinate.longitude];
    return url;
}
-(void)reverseGeocoding:(CLLocation*)location result:(void (^)(BaiduReverseGeoCodingResult * result,NSError * error))callback
{
    
    NSString * urlString = [self buildReverseGeocodingHttpUrl:location];
    NSURL *url = [NSURL URLWithString:[urlString urlencode]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BaiduReverseGeoCodingResult * reverseGeoCodingResult = [[BaiduReverseGeoCodingResult alloc]initWithJSON:responseObject];
        if (callback) {
            callback(reverseGeoCodingResult,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(nil,error);
        }
      
    }];
    
  
    [operation start];
   
}
@end
