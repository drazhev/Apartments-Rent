//
//  ApartamentsCollectionViewController.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "ApartmentsCollectionViewController.h"

@interface ApartmentsCollectionViewController ()

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext* context;
@property (nonatomic, strong) UIPopoverController* popover;
@property (nonatomic, strong) NSPredicate* searchPredicate;

@end

@implementation ApartmentsCollectionViewController

-(NSFetchedResultsController*) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Apartment" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"rooms" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:15];
    
    [fetchRequest setPredicate:self.searchPredicate];
    
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

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
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = appDelegate.managedObjectContext;
    [self.context save:nil];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"All apartments";
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                 target:self
                                 action:@selector(addButtonPressed:)];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Search"
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(searchButtonPressed:)];
    self.navigationItem.rightBarButtonItems = @[addButton];
    
    self.navigationItem.leftBarButtonItem = searchButton;
    
    
    UINib *cellNib = [UINib nibWithNibName:@"ApartmentsCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"mainCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortraitUpsideDown)
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    else
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessful"
                                                        message:@"There was a problem with the database."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)popoverSearchButtonPressedWithRooms:(int)rooms priceFrom:(int)priceFrom priceTo:(int)priceTo andLocation:(NSString *)location {
    [self.popover dismissPopoverAnimated:YES];
    
    NSMutableArray* predicates = [NSMutableArray array];
    
    if (rooms !=0) [predicates addObject:[NSPredicate predicateWithFormat:@"rooms=%d", rooms]];
    if (priceFrom != 0) [predicates addObject:[NSPredicate predicateWithFormat:@"price >= %d", priceFrom]];
    if (priceTo != 0) [predicates addObject:[NSPredicate predicateWithFormat:@"price <= %d", priceTo]];
    if ([location length] != 0) [predicates addObject:[NSPredicate predicateWithFormat:@"location CONTAINS[c] %@", location]];

    self.searchPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    _fetchedResultsController = nil;
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessful"
                                                        message:@"There was a problem with the database."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

    [self.collectionView reloadData];
    
}


-(void)searchButtonPressed: (id)sender {
    if (self.popover == nil || !self.popover.isPopoverVisible) {
        SearchPopoverViewController* popoverVC = [[SearchPopoverViewController alloc] initWithNibName:@"SearchPopoverViewController" bundle:nil];
        popoverVC.delegate = self;
        self.popover = [[UIPopoverController alloc] initWithContentViewController:popoverVC];
        [self.popover presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else {
        [self.popover dismissPopoverAnimated:YES];
        self.popover = nil;
    }
}
-(void)addButtonPressed: (id)sender {
    NewApartmentViewController* newApartmentVC = [[NewApartmentViewController alloc] initWithNibName:@"NewApartmentViewController" bundle:nil];
    [self.navigationController pushViewController:newApartmentVC animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id sectionInfo =
    [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(void)configureCell:(UICollectionViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    Apartment* apartment = [self.fetchedResultsController objectAtIndexPath:indexPath];
    ApartmentsCollectionViewCell* myCell = (ApartmentsCollectionViewCell*) cell;
    myCell.mainImageView.image = [UIImage imageNamed:apartment.imageFile];
    myCell.addressLabel.text = [NSString stringWithFormat:@"Location: %@", apartment.location];
    myCell.typeLabel.text = [NSString stringWithFormat:@"%@ EURO", apartment.price];
    myCell.priceLabel.text = [NSString stringWithFormat:@"%@ rooms", apartment.rooms];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"mainCell";
    
    ApartmentsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UICollectionView *collectionView = self.collectionView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [collectionView insertItemsAtIndexPaths:@[newIndexPath]];
            break;
            
        case NSFetchedResultsChangeDelete:
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[collectionView cellForItemAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIDeviceOrientationLandscapeLeft || toInterfaceOrientation == UIDeviceOrientationLandscapeRight) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(200, 200)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [self.collectionView setCollectionViewLayout:flowLayout];
    }
    else {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(200, 200)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [self.collectionView setCollectionViewLayout:flowLayout];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ApartmentDetailsViewController* detailsVC = [[ApartmentDetailsViewController alloc] initWithNibName:@"ApartmentDetailsViewController" bundle:nil];
    detailsVC.selectedApartment = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}


@end
