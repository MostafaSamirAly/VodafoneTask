//
//  VodafoneTask-Bridging-Header.h
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import <Foundation/Foundation.h>
#import "RepositoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RepositoryFetcherProtocol <NSObject>
- (void)fetchAt:(int) page success:(void (^)(NSArray<RepositoryModel *> *repos))successCompletion error:(void (^)(NSError *error))errorCompletion;
@end

NS_ASSUME_NONNULL_END