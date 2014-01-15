//
//  Apartment.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "Apartment.h"
#import "Comment.h"


@implementation Apartment

@dynamic imageFile;
@dynamic location;
@dynamic price;
@dynamic rooms;
@dynamic name;
@dynamic details;
@dynamic comments;

-(BOOL)validateForInsert:(NSError *__autoreleasing *)error {
    // do the appropriate validation in the model's setter and getter methods and notify the user
    // I haven't done much because it depends on the explicit application's idea
    if ([self.price intValue] <= 0) {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Price must be a positive number" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"myDomain" code:100 userInfo:errorDetail];
        return NO;
    }
    
    if ([self.rooms intValue] <= 0) {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"The number of rooms must be a positive number" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"myDomain" code:100 userInfo:errorDetail];
        return NO;
    }
    return YES;
}


@end
