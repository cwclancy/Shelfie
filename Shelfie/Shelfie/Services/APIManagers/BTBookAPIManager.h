//
//  BTBookAPIManager.h
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTBookAPIManager : NSObject
+ (instancetype) shared;
- (void)fetchBookWithIsbn:(NSString *)isbn completion:(void(^)(id book, NSError *error))completion;
@end
