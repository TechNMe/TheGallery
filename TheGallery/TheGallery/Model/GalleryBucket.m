//
//  GalleryBucket.m
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import "GalleryBucket.h"
@interface GalleryBucket()
{
}

-(NSString*)resourceURL;

//-(void)fetchDataFromServerWithCallback:(void(^)(NSError* error))completionCallback;

@end


@implementation GalleryBucket

@synthesize title = _title;

@synthesize rows = _rows;

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
- (id)copyWithZone:(NSZone *)zone {
    GalleryBucket *newObj = [[[self class] allocWithZone:zone] init];
    if(newObj)
    {
        [newObj setTitle:[self title]];
        [newObj setRows:[self rows]];
    }
    return newObj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = [[NSString alloc] init];
        _rows = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
-(void)fetchUpdatedGalleryBucketWithCallback:(void (^)(NSError *error))completionCallback
{
    NSURL* dataURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kDataURLDomain,[self resourceURL]]];
    NSURLRequest* request = [NSURLRequest requestWithURL:dataURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          dispatch_async(dispatch_get_main_queue(),^{
                                              
                                              if (!error)
                                              {
                                                  [self updateBucketWithData:data];
                                              }

                                              completionCallback(error);

                                          });
                                      }];
    [dataTask resume];
    
}

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
-(void)updateBucketWithData:(NSData*)data
{
    NSError *error = nil;
    
    NSString *asciiEncodedString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSData *utf8Data = [asciiEncodedString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* jsonObjArray = [NSJSONSerialization JSONObjectWithData:utf8Data options:NSJSONReadingMutableContainers error:&error];
    
    if (jsonObjArray)
    {
        [self setAttributesWithDictionary:jsonObjArray];
    }
    else
    {
        //Error parsing or empty data
    }
}


/*
 Function:
 Description:
 Parameters:
 Returns:
 */
-(NSString*)resourceURL
{
    return @"u/746330/facts.json";
}


/*
 Function:
 Description:
 Parameters:
 Returns:
 */
-(NSString*)classNameFor:(NSString*)inAttributeKey
{
    if ([inAttributeKey isEqualToString:@"rows"])
    {
        return @"GalleryItem";
    }
    return inAttributeKey;
}



@end
