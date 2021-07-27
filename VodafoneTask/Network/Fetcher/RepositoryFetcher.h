//
//  RepositoryFetcher.h
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import <Foundation/Foundation.h>
#import "RepositoryFetcherProtocol.h"
#import "RepositoryParserProtocol.h"
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryFetcher : NSObject<RepositoryFetcherProtocol>

@property (nonatomic, strong) id<RepositoryParserProtocol> parser;

- (instancetype)initWithParser:(id<RepositoryParserProtocol>) parser;
@end

NS_ASSUME_NONNULL_END
