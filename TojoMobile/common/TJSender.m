//
//  TJSender.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJSender.h"
#import <objc/message.h>

@implementation TJSender


- (NSMutableURLRequest *) createRequestWithMethod:(REQUEST_METHOD)method DataModel:(JSONModel *)model url:(NSString *) url
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setTimeoutInterval:REQUEST_TIMEOUT_INTERVAL];
    switch (method) {
        case REQUEST_METHOD_GET: {
            [request setHTTPMethod:@"GET"];
            unsigned int outCount;
            objc_property_t *properties = class_copyPropertyList(model.class, &outCount);
            NSMutableString *requsetParamStr = [[NSMutableString alloc] init];
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
                id value = [model valueForKey:propName];
                if (![value isKindOfClass:[NSString class]]) {
                    value = [value stringValue];
                }
                [requsetParamStr appendFormat:@"%@=%@&", propName, value];
            }
            urlString = [NSString stringWithFormat:@"%@?%@", urlString, requsetParamStr];
            break;
        }
        case REQUEST_METHOD_POST: {
            NSString *postJson = [model toJSONString];
            NSData *data = [postJson dataUsingEncoding:NSUTF8StringEncoding];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:data];
            break;
        }
        case REQUEST_METHOD_PUT: {
            NSString *postJson = [model toJSONString];
            NSData *data = [postJson dataUsingEncoding:NSUTF8StringEncoding];
            
            [request setHTTPMethod:@"PUT"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:data];
            break;
        }
        case REQUEST_METHOD_DELETE: {
            NSString *postJson = [model toJSONString];
            NSData *data = [postJson dataUsingEncoding:NSUTF8StringEncoding];
            
            [request setHTTPMethod:@"PUT"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:data];
            break;
        }
        default:
            break;
    }
    [request setValue:@"text" forHTTPHeaderField:@"content-type"];
    [request setURL:[NSURL URLWithString:urlString]];
    return request;
}
@end
