//
//  GalleryItem.h
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GalleryBase.h"

@interface GalleryItem : GalleryBase

@property (strong, atomic) NSString* title;

@property (strong, atomic) NSString* descriptionString;

@property (strong, atomic) NSString* imageHref;

@end
