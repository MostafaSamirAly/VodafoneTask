//
//  Photo.h
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject
@property NSString  *author;
@property NSString  *downloadUrl;

- (instancetype)initWithAuthor:(NSString*)author andDownloadUrl:(NSString*)downloadUrl;

@end

NS_ASSUME_NONNULL_END
