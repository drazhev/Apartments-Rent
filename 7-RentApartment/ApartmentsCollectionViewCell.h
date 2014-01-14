//
//  ApartmentsCollectionViewCell.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApartmentsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
