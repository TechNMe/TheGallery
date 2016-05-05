//
//  UIView+LoadingView.m
//  TheGallery
//
//  Created by Shruthi on 5/4/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import "UIView+LoadingView.h"

@implementation UIView (LoadingView)

-(void)addLoadingViewWithMessage:(NSString*)message
{
    UIView* loadingView             = [[UIView alloc] initWithFrame:CGRectZero];
    loadingView.backgroundColor     = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.tag                 = kLoadingViewTag;
    
    UILabel* label                  = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text                      = message;
    
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator setFrame:CGRectZero];
    
        
    //Custom Constraints for the sub views
    
    //Add label
    [loadingView addSubview:label];
    
    //Constraints for Label
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* xCenterConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:loadingView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0];
    [loadingView addConstraint:xCenterConstraint];
    
    NSLayoutConstraint* yCenterConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:loadingView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0];
    [loadingView addConstraint:yCenterConstraint];
    
    
    //Add activity indicator
    [loadingView addSubview:activityIndicator];

    //Constraints for activity indicator
    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    
    xCenterConstraint = [NSLayoutConstraint constraintWithItem:activityIndicator
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:loadingView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0];
    [loadingView addConstraint:xCenterConstraint];
    
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:activityIndicator
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:label attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0
                                                                      constant:40];
    [loadingView addConstraint:topConstraint];

    [activityIndicator startAnimating];
    
    //Finally add loading view
    [self addSubview:loadingView];
    
    //Constraints for loading view
    loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[loadingView]-0-|"
                                                                 options:0 metrics:nil
                                                                   views:@{ @"loadingView": loadingView }]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[loadingView]-0-|"
                                                                 options:0 metrics:nil
                                                                   views:@{ @"loadingView": loadingView }]];

}

-(void)removeLoadingView
{
    NSArray* subViews = [self subviews];
    for (UIView* subView in subViews)
    {
        if(subView.tag == kLoadingViewTag)
        {
            [subView removeFromSuperview];
        }
    }
}

-(void)customContraints
{
    
}

@end
