//
//  RepositoryParserProtocol.h
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RepositoryParserProtocol <NSObject>
- (void)parseRepositories:(id)data withSuccess:(void (^)(NSArray<Photo *> *repos))successCompletion error:(void (^)(NSError *error))errorCompletion;
@end

NS_ASSUME_NONNULL_END
