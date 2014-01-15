//
//  Apartment.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment;

@interface Apartment : NSManagedObject

@property (nonatomic, retain) NSString * imageFile;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * rooms;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Apartment (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
