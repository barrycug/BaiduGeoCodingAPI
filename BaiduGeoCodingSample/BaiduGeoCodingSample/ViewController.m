//
//  ViewController.m
//  BaiduGeoCodingSample
//
//  Created by baocai on 3/18/15.
//  Copyright (c) 2015 baocai. All rights reserved.
//

#import "ViewController.h"
#import "BaiduGeoCoding.h"
@interface ViewController ()
@property(nonatomic,strong)BaiduGeoCoding * baiduGeoCoding;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.baiduGeoCoding = [[BaiduGeoCoding alloc]initWithKey:@"key"];
    [self.baiduGeoCoding geocoding:@"百度大厦" city:@"北京市" result:^(BaiduGeoCodingResult *result, NSError *error) {
        NSLog(@"x=%lf,y=%lf",result.location.coordinate.longitude,result.location.coordinate.latitude);
    }];
    
    
    CLLocation *loa = [[CLLocation alloc]initWithLatitude:39.983424 longitude:116.322987];
    [self.baiduGeoCoding reverseGeocoding:loa result:^(BaiduReverseGeoCodingResult *result, NSError *error) {
        NSLog(@"%@",result.formatted_address);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
