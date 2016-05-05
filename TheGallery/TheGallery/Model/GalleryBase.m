//
//  GalleryBase.m
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import "GalleryBase.h"

@implementation GalleryBase

/*
Function: setAttributesWithDictionary
Description: Parses the the dictionary of JSON data as per the class properity keys and updates the respective property value
Parameters:
Returns:
*/
-(void)setAttributesWithDictionary:(NSDictionary*)jsonObjArray
{
    NSArray* keyArray = [jsonObjArray allKeys];
    
    for (NSString* key in keyArray)
    {
        id property = jsonObjArray[key];
        
        if([property isKindOfClass:[NSString class]] && property != nil && property != [NSNull null])
        {
            [self setValue:jsonObjArray[key] forKey:[self mappingForCodingConvention:key]];
        }
        if([property isKindOfClass:[NSArray class]] && property != nil && property != [NSNull null])
        {
            for (id propertyItem in property)
            {
                GalleryBase* object = [[NSClassFromString([self classNameFor:key]) alloc] init];
                
                [object setAttributesWithDictionary:propertyItem];
                
                NSMutableArray* array = [NSMutableArray arrayWithArray:[self valueForKey:[self mappingForCodingConvention:key]]];
                [array addObject:object];
                [self setValue:array forKey:[self mappingForCodingConvention:key]];
            }
        }
    }

}




//Property string manipulation functions
-(NSString*)mappingForCodingConvention:(NSString*)inAttributeKey
{
    //Override on if required
    return inAttributeKey;
}

-(NSString*)classNameFor:(NSString*)inAttributeKey
{
    //Override on if required
    return inAttributeKey;
}

@end
