//
//  GalleryViewController.m
//  TheGallery
//
//  Created by Shruthi on 5/3/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryTableViewCell.h"
#import "GalleryBucket.h"
#import "GalleryItem.h"
#import "UIView+LoadingView.h"

@interface GalleryViewController ()
{
    UITableView* _galleryTableView;
    
    GalleryBucket* _currentGalleryBucket;
}

@property (strong, nonatomic) UITableView* galleryTableView;

@property (strong, atomic) GalleryBucket* currentGalleryBucket;


@end

@implementation GalleryViewController

@synthesize galleryTableView = _galleryTableView;

@synthesize currentGalleryBucket = _currentGalleryBucket;


#pragma mark --UI Setup--

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialise the UI
    [self initializeView];
}

/*
 Function: initializeView
 Description: Initialize the gallary list view UI with data from server
 Parameters:
 Returns:
 */
-(void)initializeView
{
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.9746 blue:0.933 alpha:1];

    [self.view addLoadingViewWithMessage:@"Loading"];
    
    
    self.currentGalleryBucket = [[GalleryBucket alloc] init];
    
    //Fetch data for UI
    [self.currentGalleryBucket fetchUpdatedGalleryBucketWithCallback:^(NSError *error)
    {
        [self.view removeLoadingView];
        if (!error)
        {
            [self setUpTitleBar];
            [self createAndAddTableView];
        }

    }];

}

/*
 Function: setUpTitleBar
 Description: Sets the navigation title as received from the server
 Parameters:
 Returns:
 */
-(void)setUpTitleBar
{
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Helvetica-Bold" size:16] forKey:NSFontAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
    
    self.navigationItem.title = self.currentGalleryBucket.title;
    
    NSMutableDictionary *refreshButtonAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [refreshButtonAttributes setValue:[UIFont fontWithName:@"Helvetica" size:12] forKey:NSFontAttributeName];

    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(updateGalleryData:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:refreshButtonAttributes forState:UIControlStateNormal];

}


/*
 Function: createAndAddTableView
 Description: Creates the table view with data source and delegate as self
 Parameters:
 Returns:
 */
-(void)createAndAddTableView
{
    //Seyup table
    self.galleryTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.galleryTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.galleryTableView.dataSource = self;
    self.galleryTableView.delegate = self;
    
    //Beautify table view
    self.galleryTableView.backgroundColor = [UIColor colorWithRed:1.0 green:0.9746 blue:0.933 alpha:1];
    self.galleryTableView.bounces = NO;

    //Beautify seperator
    self.galleryTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.galleryTableView.separatorColor = [UIColor colorWithRed:0.37 green:0.34 blue:0.30 alpha:1];
    self.galleryTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    //Add to main view and set the constraints
    [self.view addSubview:self.galleryTableView];
    NSDictionary* views = NSDictionaryOfVariableBindings(_galleryTableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_galleryTableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[_galleryTableView]-0-|" options:0 metrics:nil views:views]];
}

#pragma mark --TableView Callbacks--

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryTableViewCell* cell = [[GalleryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    if (cell == nil)
    {
        cell = [[GalleryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }

    GalleryItem* galleryItemForCell = [_currentGalleryBucket.rows objectAtIndex:[indexPath row]];
    cell.descriptionLabel.text = galleryItemForCell.descriptionString;
    cell.titleLabel.text = galleryItemForCell.title;

    UIImage* image = nil; //TODO: Cache and load, as of now always nil
    if (image == nil)
    {
        [self lazyLoadingOfImages:galleryItemForCell cell:cell];
    }
    else
    {
        cell.imageView.image = image;
    }
    return cell;
}


/*
 Function:
 Description:
 Parameters:
 Returns:
 */
-(void)lazyLoadingOfImages: (GalleryItem *)galleryItem cell: (GalleryTableViewCell *)cell
{
    if (![galleryItem.imageHref isEqualToString:@""])
    {
        cell.imageLoadingIndicator.hidden = NO;
        [cell.imageLoadingIndicator startAnimating];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *data = [galleryItem.imageHref dataUsingEncoding:NSUTF8StringEncoding];
            NSString *imagePathEncoded = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePathEncoded]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (imageData)
                {
                    cell.imageView.image=[UIImage imageWithData:imageData];
                }
                else
                {
                    cell.imageView.image = [UIImage imageNamed:@"default.jpg"];

                }
                cell.imageLoadingIndicator.hidden = YES;
            });
        });
    }
}

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentGalleryBucket.rows count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static GalleryTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [self.galleryTableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        if (cell == nil)
        {
            cell = [[GalleryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        }
    });
    GalleryItem* galleryItemForCell = [_currentGalleryBucket.rows objectAtIndex:[indexPath row]];
    cell.descriptionLabel.text = galleryItemForCell.descriptionString;
    
    [cell layoutSubviews];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    if (cell.imageView.frame.size.height > height)
    {
        height = cell.imageView.frame.size.height;
    }
    return height +20;
}


#pragma mark --Data Management--

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
-(void)updateGalleryData:(id)sender
{
    //As of now no UI blocking while loading data.. can be enabled if required
    //[self.view addLoadingViewWithMessage:@"Loading"];

    [self.currentGalleryBucket fetchUpdatedGalleryBucketWithCallback:^(NSError *error)
     {
         //[self.view removeLoadingView];

         if (!error)
         {
             [self setUpTitleBar];

             [self.galleryTableView reloadData];
         }
     }];

}


#pragma mark --Memory Management--

/*
 Function:
 Description:
 Parameters:
 Returns:
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
