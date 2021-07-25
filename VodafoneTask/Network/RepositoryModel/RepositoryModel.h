//
//  VodafoneTask-Bridging-Header.h
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 "id": "1084",
         "author": "Jay Ruzesky",
         "width": 4579,
         "height": 3271,
         "url": "https://unsplash.com/photos/h13Y8vyIXNU",
         "download_url": "https://picsum.photos/id/1084/4579/3271"
 */
@interface RepositoryModel : NSObject
@property NSNumber  *photoId;
@property NSString  *author;
@property NSNumber  *width;
@property NSNumber  *height;
@property NSString  *url;
@property NSString  *downloadUrl;

@end

NS_ASSUME_NONNULL_END
