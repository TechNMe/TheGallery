//
//  GalleryTableViewCell.m
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import "GalleryTableViewCell.h"

@implementation GalleryTableViewCell

@synthesize imageView;

/*
 Function: initWithStyle:reuseIdentifier
 Description: Overriding for custom setup
 Parameters:
 Returns:
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self initializeView];
    
    [self setupCustomConstraints];
    
    return self;
}

/*
 Function: initializeView
 Description:Initialize this cell view designing specifically for the gally list view requirement
 Parameters:
 Returns:
 */
- (void)initializeView
{
    self.backgroundColor = [UIColor colorWithRed:1.0 green:0.9746 blue:0.933 alpha:1];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 100, 90)];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = 10.0;
    [self.contentView addSubview:self.imageView];
    
    
    self.imageLoadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.imageLoadingIndicator  setFrame:CGRectMake(35, 40, 50, 50)];
    [self.contentView addSubview:self.imageLoadingIndicator];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 100, 20)];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = kRowTitleFont;
    [self.contentView addSubview:self.titleLabel];

    
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.font = kRowDescriptioFont;
    [self.contentView addSubview:self.descriptionLabel];

}


/*
 Function: setupCustomConstraints
 Description: Setup constaints to the label view for growing the cell in accordance with the description label hight
 Parameters:
 Returns:
 */
-(void)setupCustomConstraints
{
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString* horizontalConstraintDescription = [NSString stringWithFormat:@"H:|-%d-[bodyLabel]-10-|",(int)(CGRectGetMaxX(self.imageView.frame)) + 10];
    NSString* verticalConstraintDescription = [NSString stringWithFormat:@"V:|-%d-[bodyLabel]-5-|",(int)(CGRectGetMaxY(self.titleLabel.frame))];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintDescription options:0 metrics:nil views:@{ @"bodyLabel": self.descriptionLabel }]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintDescription options:0 metrics:nil views:@{ @"bodyLabel": self.descriptionLabel }]];

}

/*
 Function: setSelected:animated
 Description:
 Parameters:
 Returns:
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


/*
 Function: layoutSubviews
 Description: Overriding layout subviews growing the cell in accordance with the description label hight
 Parameters:
 Returns:
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.descriptionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descriptionLabel.frame);
}


@end
