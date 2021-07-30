//
//  RepositoryParser.m
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import "RepositoryParser.h"

@implementation RepositoryParser

- (void)parseRepositories:(id)data withSuccess:(void (^)(NSArray<Photo *> *repos))successCompletion error:(void (^)(NSError *error))errorCompletion {
    
    NSArray *fetchedArray = data;
    NSMutableArray<Photo *> *repos = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < fetchedArray.count ; i++ ){
        Photo *repo = [[Photo alloc] init];
        repo.author = [fetchedArray objectAtIndex:i][@"author"];
        repo.downloadUrl = [fetchedArray objectAtIndex:i][@"download_url"];
        [repos addObject:repo];
    }
    successCompletion(repos);
}

@end
