//
//  RepositoryFetcher.m
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import "Fetcher.h"


@implementation Fetcher


- (instancetype)initWithParser:(id<ParserProtocol>)parser{
    self.parser = parser;
    return self;
}

- (void)fetchAt:(int)page success:(void (^)(NSArray<Photo *> *repos))successCompletion error:(void (^)(NSError *error))errorCompletion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString* urlString = [NSString stringWithFormat:@"https://picsum.photos/v2/list?page=%i&limit=10", page];
    NSURL *URL = [NSURL URLWithString: urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:NULL downloadProgress:NULL completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            errorCompletion(error);
        } else {

            [self.parser parseData:responseObject withSuccess:successCompletion error:errorCompletion];
        }
    }];
    [dataTask resume];
}

@end
