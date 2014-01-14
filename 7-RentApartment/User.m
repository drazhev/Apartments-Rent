//
//  User.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic username;
@dynamic firstName;
@dynamic lastName;
@dynamic age;
@dynamic address;
@dynamic password;

-(BOOL)validateForInsert:(NSError *__autoreleasing *)error {
    // do the appropriate validation in the model's setter and getter methods and notify the user
    // I haven't done much because it depends on the explicit application's idea
    if ([self.age intValue] <= 0) {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Age must be a positive number" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"myDomain" code:100 userInfo:errorDetail];
        return NO;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.sortDescriptors = nil;
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"username = %@", self.username]];
    
    NSArray* results = [self.managedObjectContext executeFetchRequest:request error:nil];
    if ([results count] > 1) {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Username already exists" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"myDomain" code:100 userInfo:errorDetail];
        return NO;
    }
    return YES;
}

@end
