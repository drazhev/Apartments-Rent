//
//  Apartment.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Apartment : NSManagedObject

@property (nonatomic, retain) NSNumber * rooms;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * imageFile;
@property (nonatomic, retain) NSNumber * price;

@end
