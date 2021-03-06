//
//  AppDelegate.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(NSString *) genRandStringLength: (int) len {
    NSString *letters = @"abcde fghij klmno pqrst uvwxy zABCD EFGHI JKLMN OPQRS TUVWX YZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}

-(void) insertRandomApartment {
    Apartment* newApartment = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment" inManagedObjectContext:self.managedObjectContext];
    newApartment.imageFile = @"defaultImage.png";
    newApartment.location = [self genRandStringLength:10];
    newApartment.rooms = [NSNumber numberWithInt:arc4random() % 5 + 1];
    newApartment.price = [NSNumber numberWithInt:arc4random() % 500 + 100];
    newApartment.details = [self genRandStringLength:1000];
    newApartment.name = [self genRandStringLength:10];
    
    for (int i = 0; i < arc4random() % 20 + 1; i++) {
        
        Comment* newComment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.managedObjectContext];
        newComment.message = [NSString stringWithFormat:@"This is a random comment message: %@", [self genRandStringLength:1000]];
        newComment.dateAdded = [NSDate date];
        
        User* newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
        newUser.username = [NSString stringWithFormat:@"%@ (random username)",[self genRandStringLength:10]];
        newUser.age = [NSNumber numberWithInt:arc4random() % 100 + 1];
        newComment.author = newUser;
        
        [newApartment addCommentsObject:newComment];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    LoginViewController* loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController* mainNavigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = mainNavigationController;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Apartment"];
    request.sortDescriptors = nil;
    
    NSArray* results = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if (results.count == 0) {
    
        for (int i=0; i < 50; i++) {
            [self insertRandomApartment];
        }
        
        [self.managedObjectContext save:nil];
    }
    [NSTimer scheduledTimerWithTimeInterval:10.00
                                     target:self
                                   selector:@selector(updateApartments)
                                   userInfo:nil
                                    repeats:YES];
    return YES;
}

-(void)updateApartments {
    // save is needed after every change because it leads to issues in the FetchedResultsController otherwise!
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Apartment"];
    request.sortDescriptors = nil;
    NSArray* results = [self.managedObjectContext executeFetchRequest:request error:nil];
    Apartment* randomApartment;
    do {
        randomApartment = (Apartment*)results[arc4random() % results.count];
    }
    // this is to prevent the random function from modifying the apartment that we are reviewing
    while (randomApartment == self.selectedApartment);
    randomApartment.location = [self genRandStringLength:10];
    randomApartment.rooms = [NSNumber numberWithInt:arc4random() % 5 + 1];
    randomApartment.price = [NSNumber numberWithInt:arc4random() % 500 + 100];
    randomApartment.details = [self genRandStringLength:1000];
    randomApartment.name = [self genRandStringLength:10];
    [self.managedObjectContext save:nil];
    
    [self insertRandomApartment];
    [self.managedObjectContext save:nil];
    // this is to prevent the random function from modifying the apartment that we are reviewing
    do {
        randomApartment = (Apartment*)results[arc4random() % results.count];
    }
    while (randomApartment == self.selectedApartment);
    [self.managedObjectContext deleteObject:results[arc4random() % results.count]];
    [self.managedObjectContext save:nil];
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"__RentApartment" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"__RentApartment.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
