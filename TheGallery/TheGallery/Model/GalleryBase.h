//
//  GalleryBase.h
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface GalleryBase : NSObject 

-(void)setAttributesWithDictionary:(NSDictionary*)dictionary;

-(NSString*)classNameFor:(NSString*)inAttributeKey;

@end
