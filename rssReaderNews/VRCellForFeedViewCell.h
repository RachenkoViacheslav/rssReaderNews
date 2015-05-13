//
//  VRCellForFeedViewCell.h
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRCellForFeedViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *feedsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedPubDataLabel;
@property (weak, nonatomic) IBOutlet UIImageView *feedSmallPhoto;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@end
