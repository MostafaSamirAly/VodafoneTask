//
//  Photo.h
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject
@property NSNumber  *photoId;
@property NSString  *author;
@property NSNumber  *width;
@property NSNumber  *height;
@property NSString  *url;
@property NSString  *downloadUrl;

@end

NS_ASSUME_NONNULL_END
