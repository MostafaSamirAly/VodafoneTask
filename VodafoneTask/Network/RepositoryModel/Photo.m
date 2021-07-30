//
//  Photo.m
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithAuthor:(NSString*)author andDownloadUrl:(NSString*)downloadUrl {
    self.downloadUrl = downloadUrl;
    self.author = author;
    return self;
}

@end
