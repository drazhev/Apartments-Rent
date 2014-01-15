//
//  ApartmentDetailsViewController.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Apartment.h"
#import "CommentsTableViewController.h"
#import "AppDelegate.h"

@interface ApartmentDetailsViewController : UIViewController

@property (nonatomic, strong) Apartment* selectedApartment;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@end
