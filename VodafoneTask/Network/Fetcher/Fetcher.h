//
//  RepositoryFetcher.h
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import <Foundation/Foundation.h>
#import "FetcherProtocol.h"
#import "ParserProtocol.h"
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface Fetcher : NSObject<FetcherProtocol>

@property (nonatomic, strong) id<ParserProtocol> parser;

- (instancetype)initWithParser:(id<ParserProtocol>) parser;
@end

NS_ASSUME_NONNULL_END
