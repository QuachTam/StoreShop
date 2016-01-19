//
//  SDAFParseAPIClient.m
//  StoreManager
//
//  Created by Tamqn on 1/18/16.
//  Copyright © 2016 ATam. All rights reserved.
//

#import "SDAFParseAPIClient.h"

static NSString * const kSDFParseAPIBaseURLString = @"https://api.parse.com/1/";

static NSString * const kSDFParseAPIApplicationId = @"Nq0V3ipnh8rQw00UuvDLdI6GmkuXRWAc2WNh9rp2";
static NSString * const kSDFParseAPIKey = @"quVE0qbs9OuFRxbhyZ7ysR7PxOO15k25W2ZG7Xh9";
@implementation SDAFParseAPIClient

+ (instancetype)sharedClient {
    static SDAFParseAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SDAFParseAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kSDFParseAPIBaseURLString]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self.requestSerializer setValue:kSDFParseAPIApplicationId forHTTPHeaderField:kSDFParseAPIApplicationId];
        [self.requestSerializer setValue:kSDFParseAPIKey forHTTPHeaderField:kSDFParseAPIKey];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        [self setResponseSerializer:responseSerializer];
    }
    
    return self;
}

- (void)getRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters {
    [[SDAFParseAPIClient sharedClient] GET:[NSString stringWithFormat:@"classes/%@", className] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
