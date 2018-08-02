//
//  BTBookAPIManager.m
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTBookAPIManager.h"
#import <Parse/Parse.h>

@implementation BTBookAPIManager

+ (instancetype)shared {
    static BTBookAPIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}



- (void)fetchBookWithIsbn:(NSString *)isbn completion:(void(^)(id book, NSError *error))completion {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body,
                             isbn];
    NSURL *url = [NSURL URLWithString:url_request];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
     NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
        } else {
            completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil], nil);
        }
    }];
    [task resume];
}


@end
