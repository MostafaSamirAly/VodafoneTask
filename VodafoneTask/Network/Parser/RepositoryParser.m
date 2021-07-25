//
//  RepositoryParser.m
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import "RepositoryParser.h"

@implementation RepositoryParser

- (void)parseRepositories:(id)data withSuccess:(void (^)(NSArray<Photo *> *repos))successCompletion error:(void (^)(NSError *error))errorCompletion {
    
    NSArray *fetchedArr = data;
    NSMutableArray<Photo *> *repos = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < fetchedArr.count ; i++ ){
        Photo *repo = [[Photo alloc] init];
        repo.photoId = [fetchedArr objectAtIndex:i][@"id"];
        repo.author = [fetchedArr objectAtIndex:i][@"author"];
        repo.width = [fetchedArr objectAtIndex:i][@"width"];
        repo.height = [fetchedArr objectAtIndex:i][@"height"];
        repo.url = [fetchedArr objectAtIndex:i][@"url"];
        repo.downloadUrl = [fetchedArr objectAtIndex:i][@"download_url"];
        [repos addObject:repo];
    }
    successCompletion(repos);
}

@end
