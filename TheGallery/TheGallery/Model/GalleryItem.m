//
//  GalleryItem.m
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import "GalleryItem.h"

@implementation GalleryItem

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
//        _title = [[NSString alloc] init];
//        _descriptionString = [[NSString alloc] init];
//        _imageHref = [[NSString alloc] init];
    }
    return self;
}

/*
 Function: mappingForCodingConvention
 Description:Property string manipulation functions, such as if the JSON key is 'description'
 Parameters:
 Returns:
 */
-(NSString*)mappingForCodingConvention:(NSString*)inAttributeKey
{
    if ([inAttributeKey isEqualToString:@"description"])
    {
        return @"descriptionString";
    }
    return inAttributeKey;
}

@end
