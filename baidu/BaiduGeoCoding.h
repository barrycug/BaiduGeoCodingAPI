//
//  BaiduGeoCoding.h
//  Flashlight
//
//  Created by baocai on 3/17/15.
//  Copyright (c) 2015 baocai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@protocol BaiduCoding<NSObject>
-(id)initWithJSON:(id)json;
@end
@interface BaiduGeoCodingResult : NSObject<BaiduCoding>
@property(nonatomic,assign)int status;
@property(nonatomic,strong)CLLocation *location;
@property(nonatomic,assign)int precise;
@property(nonatomic,assign)int confidence;
@property(nonatomic,strong)NSString * level;

-(id)initWithJSON:(id)json;
@end

@interface BaiduAddrComponent : NSObject<BaiduCoding>
@property(nonatomic,strong)NSString * city;
@property(nonatomic,strong)NSString * district;
@property(nonatomic,strong)NSString * province;
@property(nonatomic,strong)NSString * street;
@property(nonatomic,strong)NSString * street_number;
-(id)initWithJSON:(id)json;
@end


@interface BaiduPOI : NSObject<BaiduCoding>
@property(nonatomic,strong)NSString * addr;
@property(nonatomic,strong)NSString * cp;
@property(nonatomic,assign)double  distance;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * poiType;
@property(nonatomic,strong)CLLocation * point;
@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSString * zip;
-(id)initWithJSON:(id)json;
@end


@interface BaiduReverseGeoCodingResult : NSObject<BaiduCoding>
@property(nonatomic,assign)int status;
@property(nonatomic,strong)CLLocation *location;
@property(nonatomic,strong)NSString *formatted_address;
@property(nonatomic,strong)NSString *business;
@property(nonatomic,strong)BaiduAddrComponent *addrComponent;
@property(nonatomic,strong)NSArray *pois;
-(id)initWithJSON:(id)json;
@end

@interface BaiduGeoCoding : NSObject
-(id)initWithKey:(NSString*)key;
-(id)initWithUrl:(NSString*)url andKey:(NSString*)key;
-(void)geocoding:(NSString*)address city:(NSString*)city result:(void (^)(BaiduGeoCodingResult * result,NSError * error))callback;
-(void)reverseGeocoding:(CLLocation*)location result:(void (^)(BaiduReverseGeoCodingResult * result,NSError * error))callback;
@end
