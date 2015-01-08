//
//  TJSender.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJSystemParam.h"
#import <JSONModel.h>

typedef enum {
    REQUEST_METHOD_GET = 0,
    REQUEST_METHOD_POST,
    REQUEST_METHOD_PUT,
    REQUEST_METHOD_DELETE
}REQUEST_METHOD;

@interface TJSender : NSObject


//- (NSMutableURLRequest *) createGetRequestWithDataModel:(JSONModel *)model url:(NSString *) url;
//
//- (NSMutableURLRequest *) createPostRequestWithDataModel:(JSONModel *)model url:(NSString *) url;
//
//- (NSMutableURLRequest *) createPutRequestWithDataModel:(JSONModel *)model url:(NSString *) url;
//
//- (NSMutableURLRequest *) createDeleteRequestWithDataModel:(JSONModel *)model url:(NSString *) url;

- (NSMutableURLRequest *) createRequestWithMethod:(REQUEST_METHOD)method DataModel:(JSONModel *)model url:(NSString *) url;

@end
