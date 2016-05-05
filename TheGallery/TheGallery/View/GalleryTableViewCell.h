//
//  GalleryTableViewCell.h
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryTableViewCell : UITableViewCell
{
    UILabel * _descriptionLabel;
    
    UIImageView * _imageView;
    
    UILabel * _titleLabel;
    
    UIActivityIndicatorView * _imageLoadingIndicator;
}

@property (strong, nonatomic) UILabel *descriptionLabel;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIActivityIndicatorView *imageLoadingIndicator;

@end
