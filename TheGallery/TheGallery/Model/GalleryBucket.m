//
//  GalleryBucket.m
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import "GalleryBucket.h"
@interface GalleryBucket()

-(NSString*)resourceURL;

@end


@implementation GalleryBucket

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
//        _rows = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
 Function: fetchUpdatedGalleryBucketWithCallback
 Description: Fetches the data for the model from server. Executes completion block once the session request is executed
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
 Function: updateBucketWithData
 Description: Prases the JSON response and sets the attributes of the model. This can be optimized and implemented in GallertyBase
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
 Function:resourceURL
 Description: Returns the resource url of the model
 Parameters:
 Returns:
 */
-(NSString*)resourceURL
{
    return @"u/746330/facts.json";
}


/*
 Function:classNameFor
 Description: Property string manipulation functions. In cases of having a class with different name than that of JSON response key
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
