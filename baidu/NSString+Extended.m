//
//  NSString+Extended.m
//  Flashlight
//
//  Created by baocai on 3/17/15.
//  Copyright (c) 2015 baocai. All rights reserved.
//

#import "NSString+Extended.h"

@implementation NSString (Extended)
- (NSString *)urlencode {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}
@end
