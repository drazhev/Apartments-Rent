//
//  ApartmentDetailsViewController.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "ApartmentDetailsViewController.h"

@interface ApartmentDetailsViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation ApartmentDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // this is to prevent the random function from modifying the apartment that we are reviewing
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.appDelegate.selectedApartment = self.selectedApartment;
    
    self.title = @"Apartment details";
    UIBarButtonItem *commentsButon = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Comments"
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(commentsButtonTapped:)];
    self.navigationItem.rightBarButtonItem = commentsButon;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@", self.selectedApartment.price];
    self.locationLabel.text = self.selectedApartment.location;
    self.nameLabel.text = self.selectedApartment.name;
    self.typeLabel.text = [NSString stringWithFormat:@"%@",self.selectedApartment.rooms];
    self.mainImageView.image = [UIImage imageNamed:self.selectedApartment.imageFile];
    self.detailsTextView.text = self.selectedApartment.details;

    // Do any additional setup after loading the view from its nib.
}

-(void)commentsButtonTapped: (id) sender {
    CommentsTableViewController* commentsVC = [[CommentsTableViewController alloc] initWithNibName:@"CommentsTableViewController" bundle:nil];
    commentsVC.currentComments = [self.selectedApartment.comments allObjects];
    [self.navigationController pushViewController:commentsVC animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    self.appDelegate.selectedApartment = nil;
}

@end
