//
//  Comment.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Apartment, User;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) User *author;
@property (nonatomic, retain) Apartment *onApartment;

@end
