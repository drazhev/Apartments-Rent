//
//  SearchPopoverViewController.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverDelegate <NSObject>

-(void)popoverSearchButtonPressedWithRooms: (int) rooms priceFrom: (int) priceFrom priceTo: (int) priceTo andLocation: (NSString*) location;

@end

@interface SearchPopoverViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) UIPopoverController* myPopoverController;
@property (weak, nonatomic) id<PopoverDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *roomsTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceToTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@end
