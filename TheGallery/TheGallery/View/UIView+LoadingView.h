//
//  UIView+LoadingView.h
//  TheGallery
//
//  Created by Shruthi on 5/4/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadingView)

-(void)addLoadingViewWithMessage:(NSString*)message;

-(void)removeLoadingView;

@end