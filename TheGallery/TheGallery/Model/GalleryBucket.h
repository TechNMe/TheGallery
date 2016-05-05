//
//  GalleryBucket.h
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GalleryBase.h"

@interface GalleryBucket : GalleryBase

@property (strong, atomic) NSString* title;

@property (strong, atomic) NSMutableArray* rows;

-(void)fetchUpdatedGalleryBucketWithCallback: (void (^)(NSError* error)) callabck;

@end
