//
//  CommentsTableViewController.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CommentsTableViewCell.h"
#import "Comment.h"

@interface CommentsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* currentComments;

@end
