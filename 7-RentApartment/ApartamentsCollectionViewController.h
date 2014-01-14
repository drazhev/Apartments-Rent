//
//  ApartamentsCollectionViewController.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApartmentsCollectionViewCell.h"
#import "AppDelegate.h"
#import "Apartment.h"

@interface ApartamentsCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate>

@end
